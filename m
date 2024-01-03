Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661A179A1;
	Wed,  3 Jan 2024 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdL/xiqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704257715; x=1735793715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwcgHyf2clMX/2mSlPKtbei8nLICIiRQRSs8SIsGMqc=;
  b=XdL/xiqHRgXlMAju7Frhgvnnwad6msdl8avslyCXCXZj7W22s60ajgA8
   8Olk1P4uhqj4Dn2/ypCcjjrHJ/qt4P6e6midPRrR2kF5wn5b7sOrwdet8
   bbW0pJMorN17G+eRrY5QQrvdVVvPcx35vex+YJoAx9tPM9XO35tNE3Coz
   Doei0ABhweutfUx/UdSbMgKxvI7X56skJwDeDWv4yEfvVHvQX5ETboxzB
   i3qXddCFB8x5fns2/iAbJlhzghLhlPt5cOeiWzM/+GUrT9AEd5TARGEdu
   ZDJvLF77DbccjrNAJSUDgsTr54VNapoiH6O6LtXHalY2FITay8dEPJq+S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3774254"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3774254"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111248794"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1111248794"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jan 2024 20:55:08 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [Regression] [iommu/iova] iova_rbtree_lock contended seriously causing performance bottleneck (bisect done; commit found) 
Date: Tue,  2 Jan 2024 23:55:06 -0500
Message-Id: <20240103045506.1077586-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

flame graph


                                   queued_spin_lock_slowpath-------------\
                                  do_raw_spin_lock                       \
                                 _raw_spin_lock_irqsave                  \
                                __alloc_and_insert_iova_range            \  
                               alloc_iova_fast                           \
                              iommu_dma_alloc_iova                       \
                             __iommu_dma_map                             \
                            iommu_dma_map_page                           \
                           ice_tx_map.isra.0                             \
                          ice_xmit_frame_ring                            \
	                     dev_hard_start_xmit                             \
                        sch_direct_xmit                                  \ 
                       __dev_xmit_skb                                    \
                      __dev_queue_xmit                                   \
                     ip_finish_output2                                   \ 
				     __ip_queue_xmit                                     \
				    __tcp_transmit_skb                                   \ 
				    tcp_write_xmit                                       \
				   __tcp_push_pending_frames                             \
				  tcp_sendmsg_locked                                     \
                 tcp_sendmsg                                             \
                tcp_sendmsg                                              \
               sock_write_iter                                           \
              do_iter_readv_writev                                       \
             do_iter_write                                               \
            vfs_writev                                                   \
           do_writev                                                     \
           do_syscall_64                                                 \
          entry_SYSCALL_64_after_hwframe                                 \
         __GI___writev                                                   \
         [nginx]                                                         \
        ngx_linux_sendfile_chain                                         \
       ngx_http_write_filter                                             \
      ngx_output_chain                                                   \
     ngx_http_send_response                                              \
    ngx_http_script_return_code                                          \
  [nginx]                                                                \
 ngx_http_core_run_phases                                                \
ngx_http_process_request                                                 \

Setup:                                          
1. configure server nginx with following nginx.conf (appended to the tail)

2. request server with WRK
   ./wrk -t 64 -c 1024 -d 40 --latency http://$server_ip:10802/1KB.json

Debugging summary:
 Bisect identified "commit 371d7955e310 iommu/iova: Improve restart logic"
 as cause.

nginx.conf
user nginx; 
worker_processes 16;
error_log /var/log/nginx/error.log crit;
pid /var/run/nginx.pid; 
events {
worker_connections 4000;
use epoll;
multi_accept on;
}
http {
include /etc/nginx/mime.types; 
default_type application/octet-stream;
log_format main '$remote_addr - $remote_user [$time_local] "$request" '
		'$status $body_bytes_sent "$http_referer" '
		'"$http_user_agent" "$http_x_forwarded_for"';
access_log off;
sendfile on;
tcp_nopush on;
tcp_nodelay on;
keepalive_timeout 65; 
keepalive_requests 20480; 
gzip_min_length 10240;
gzip_comp_level 1;
gzip_vary on;
gzip_disable msie6;
gzip_proxied expired no-cache no-store private auth; 
gzip_types
# text/html is always compressed by HttpGzipModule
	text/css
	text/javascript
	text/xml
	text/plain
	text/x-component 
	application/javascript 
	application/x-javascript 
	application/json 
	application/xml 
	application/rss+xml 
	application/atom+xml 
	font/truetype
	font/opentype 
	application/vnd.ms-fontobject 
	image/svg+xml;

reset_timedout_connection on;
client_body_timeout 10;
send_timeout 2;
include /etc/nginx/conf.d/*.conf; 
server {
	listen 10802;
    server_name  localhost;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        #root   /usr/share/nginx/html;
        root   /ramdisk;
	}
    location /1KB.json {
               return 202 '{"status":"success","result":"\
                           Hello from  NGINX, 2KB test\
                           Nanchang, which was the capital of Yuzhang Prefecture during the HanDynasty, \
                           now falls under the jurisdiction of Hongzhou. It straddles the borderof the \
                           influence of the Ye and Zhen constellations , and is adjacent to theHeng \
                           and the Lu mountains . The three rivers enfold it like the frontpart \
                           of a garment and the five lakes encircle it like a girdle. Itcontrols \
                           nature’s jewels. The radiance of its legendary sword shootsdirectly upward \
                           between the constellations Niu and Dou. Its talented peopleare outstanding,\
                           and the spirit of intelligence pervades the place. This wasthe place where Xu \
                           Ru spent the night on his visit to Chen Fan (10). The mightyHongzhou spreads \
                           meteors chasing one another.\
                           "}';
          }
 }
}
-- 
2.31.1

