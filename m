Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD5C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:19:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B7E2245C
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B7E2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68A3A86FAF;
	Wed, 20 Jan 2021 02:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P73d71gsDGEp; Wed, 20 Jan 2021 02:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C931A86D5A;
	Wed, 20 Jan 2021 02:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E1BC08A1;
	Wed, 20 Jan 2021 02:19:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 096B8C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EC840845A3
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id asz_X10uon_s for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:19:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 91F4B8453B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:19:28 +0000 (UTC)
IronPort-SDR: yQouTRuBXQOtAgPwAsSi0FX4NqFKNcwXs6QxHKWNoC4Wbwk1wWl85o99IzQ5jmDAj3ZPboK2uw
 AQrXNWnJhPbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="166695518"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="166695518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 18:19:27 -0800
IronPort-SDR: KBaqGuVhwUADj+5zuhsRdrgXO822NRFc2xAMPmreV8fFKdt29AdMT+ihcegqFGqVdARj8VPH3z
 9AOyCLyrMLrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="466919841"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 18:19:24 -0800
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To: Chuck Lever <chuck.lever@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
 <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
Date: Wed, 20 Jan 2021 10:11:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/19/21 10:37 PM, Chuck Lever wrote:
> 
> 
>> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Do you mind posting the cap and ecap of the iommu used by your device?
>>
>> You can get it via sysfs, for example:
>>
>> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
>> address  cap  domains_supported  domains_used  ecap  version
> 
> [root@manet intel-iommu]# lspci | grep Mellanox
> 03:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> [root@manet intel-iommu]# pwd
> /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
> [root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; done
> address : c7ffc000
> cap : d2078c106f0466

MGAW: 101111 (supporting 48-bit address width)
SAGAW: 00100 (supporting 48-bit 4-level page table)

So the calculation of domain->domain.geometry.aperture_end is right.

> domains_supported : 65536
> domains_used : 62
> ecap : f020de
> version : 1:0
> [root@manet intel-iommu]#
> 
> 
>>> Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
>>> E5-2603 v3 @ 1.60GHz CPUs.
>>
>> Can you please also hack a line of code to check the return value of
>> iommu_dma_map_sg()?
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index baca49fe83af..e811562ead0e 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -328,6 +328,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>   
>          dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg, mr->mr_nents,
>                                    mr->mr_dir);
> +       trace_printk("ib_dma_map_sg(%d) returns %d\n", mr->mr_nents, dma_nents);
>          if (!dma_nents)
>                  goto out_dmamap_err;
>          mr->mr_device = ep->re_id->device;
> 
> During the 256KB iozone test I used before, this trace log is generated:
> 
>     kworker/u28:3-1269  [000]   336.054743: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.054835: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055022: bprint:               frwr_map: ib_dma_map_sg(4) returns 1
>     kworker/u28:3-1269  [000]   336.055118: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055312: bprint:               frwr_map: ib_dma_map_sg(30) returns 1
>     kworker/u28:3-1269  [000]   336.055407: bprint:               frwr_map: ib_dma_map_sg(4) returns 1

This is the result after commit c062db039f40, right? It also looks good
to me. Are you using iotlb strict mode (intel_iommu=strict) or lazy mode
(by default)?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
