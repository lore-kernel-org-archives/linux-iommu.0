Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B881C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 14:44:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03A9207FB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 14:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03A9207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8723A2043E;
	Tue, 19 Jan 2021 14:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8x+2WJbiNG-m; Tue, 19 Jan 2021 14:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3CF6A1FE49;
	Tue, 19 Jan 2021 14:44:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10098C08A1;
	Tue, 19 Jan 2021 14:44:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBC19C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 14:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BADFD203E9
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 14:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2snCkD2893ap for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 14:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id AA9051FE49
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 14:44:54 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JEeH7T034622;
 Tue, 19 Jan 2021 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Xs7XcSPuXtCAy9E1BtGD/cICdsavHCcacyUpBLbq1A4=;
 b=BusxizjtMEoqCd/hKEzruaZv+e0k/XUtX9OAhGd/PhGbFJkCpPGdHYNyk3PYqshrCRLV
 nY7BHY9jJ/SZtYM7oTiXDyxTtg3NYP6fLV6oucSThg5v3QUupYbUpkmumpDLj+ppJz1A
 neH6nKXvevoUCwuebAcQl2wZxGf+dla0Kp0WK7YeqrfOlW6UWbzS/hhxYB7eAJTICmq6
 MuOgx0chYu4up2VlSywtXZLCXIfeNApQ9Apy5smeHq0AOUd87M5d9xi8UPH38+OjMVTS
 ss1ujty/wyK2ifAjwA3X9YdbynKy5ZhxukL22R/XwfD5ATlt5Jd43aI2aW3M6jAK++iV 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 363r3ksa9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Jan 2021 14:44:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JEi9CL102060;
 Tue, 19 Jan 2021 14:44:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3649wrnk6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Jan 2021 14:44:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JEbmaA001956;
 Tue, 19 Jan 2021 14:37:49 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 19 Jan 2021 06:37:48 -0800
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
Date: Tue, 19 Jan 2021 09:37:47 -0500
Message-Id: <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190089
Cc: linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
 Robin Murphy <robin.murphy@arm.com>, murphyt7@tcd.ie,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> Do you mind posting the cap and ecap of the iommu used by your device?
> 
> You can get it via sysfs, for example:
> 
> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
> address  cap  domains_supported  domains_used  ecap  version

[root@manet intel-iommu]# lspci | grep Mellanox
03:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
[root@manet intel-iommu]# pwd
/sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
[root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; done
address : c7ffc000
cap : d2078c106f0466
domains_supported : 65536
domains_used : 62
ecap : f020de
version : 1:0
[root@manet intel-iommu]#


>> Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
>> E5-2603 v3 @ 1.60GHz CPUs.
> 
> Can you please also hack a line of code to check the return value of
> iommu_dma_map_sg()?

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index baca49fe83af..e811562ead0e 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -328,6 +328,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 
        dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg, mr->mr_nents,
                                  mr->mr_dir);
+       trace_printk("ib_dma_map_sg(%d) returns %d\n", mr->mr_nents, dma_nents);
        if (!dma_nents)
                goto out_dmamap_err;
        mr->mr_device = ep->re_id->device;

During the 256KB iozone test I used before, this trace log is generated:

   kworker/u28:3-1269  [000]   336.054743: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.054835: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055022: bprint:               frwr_map: ib_dma_map_sg(4) returns 1
   kworker/u28:3-1269  [000]   336.055118: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055312: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
   kworker/u28:3-1269  [000]   336.055407: bprint:               frwr_map: ib_dma_map_sg(4) returns 1

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
