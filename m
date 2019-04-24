Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA8CC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:25:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989BE20811
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZ/e0a17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989BE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C44F1386;
	Wed, 24 Apr 2019 14:25:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC5B5137F
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7494574A
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:25:08 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OEOJqL063005; Wed, 24 Apr 2019 14:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : mime-version : content-type; s=corp-2018-07-02;
	bh=hsjDs57SVOaK6ewTS9FA0UM34VrieOZC/Ynw3CJVQIc=;
	b=TZ/e0a17UKG8YesqubHhK+bjAzascJchEetsa78KhvuC63Ysn9byQjNqaxq2U+IFvyot
	390FqkD3pbyVDYzRHtAZt4oxDv2avsR7mIfkPGC14xiY/P7l4hXRFGn3xBs5hs/3MUN4
	tHyaLY8M4q/2ruVd536qmEGHjQ9YTtlO7WI14LA2PUfClZIsVg2xmBUbDCuXLZkpQO3K
	LrISLM8yxYYKcv1Xh+elCFrtUYFqf97Qkv3L2xBrb9xCIbuIDj3o2SndQ8SY2rB5f5y1
	bv49wsLr18xaQGuY0URbbxAn08hwAwN9PBHUpMFxfdhWE7iQsGp9G8bfEhTw1MpmJY0L
	dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rytut2qy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 14:25:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OEORY4044360; Wed, 24 Apr 2019 14:25:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2s0fv3kpe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 14:25:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3OEOtUx021976;
	Wed, 24 Apr 2019 14:24:55 GMT
Received: from mwanda (/196.111.187.26)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Apr 2019 07:24:54 -0700
Date: Wed, 24 Apr 2019 17:24:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>, Ian Abbott <abbotti@mev.co.uk>,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190424142437.GA29490@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904240112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904240113
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"kernel-janitors@vger.kernel.org H Hartley Sweeten"
	<hsweeten@visionengravers.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424142437.k-CTNSB--nwKJelsZZhNszXAQgVrIjVWps7xQ0GEG98@z>

We already dereferenced "dev" when we called get_dma_ops() so this NULL
check is too late.  We're not supposed to pass NULL "dev" pointers to
dma_alloc_attrs().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
There are still at least two drivers which do pass a NULL unfortunately.

drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'
drivers/tty/synclink.c:3667 mgsl_alloc_buffer_list_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
drivers/tty/synclink.c:3738 mgsl_free_buffer_list_memory() error: NULL dereference inside function 'dma_free_coherent()'
drivers/tty/synclink.c:3777 mgsl_alloc_frame_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
drivers/tty/synclink.c:3811 mgsl_free_frame_memory() error: NULL dereference inside function 'dma_free_coherent()'

If I remember right there are one or two others which sometimes pass a
NULL, but it's harder to grep for those warnings.

 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 685a53f2a793..f7afdadb6770 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -244,7 +244,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
 
-	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
