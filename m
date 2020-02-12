Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB6CC35242
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 00:16:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17152206D6
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 00:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17152206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tomt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D70DC203A3;
	Wed, 12 Feb 2020 00:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vBoKtrD7hp-u; Wed, 12 Feb 2020 00:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D918420022;
	Wed, 12 Feb 2020 00:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B52E9C1D80;
	Wed, 12 Feb 2020 00:16:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 855CDC07FE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6FD6C84D09
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cK0qHc_FsGL9 for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 00:16:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail1.ugh.no (mail1.ugh.no [178.79.162.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E324984CA5
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail1.ugh.no (Postfix) with ESMTP id 987DF24EA99;
 Wed, 12 Feb 2020 01:16:36 +0100 (CET)
Received: from mail1.ugh.no ([127.0.0.1])
 by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BqjRa5j_czg; Wed, 12 Feb 2020 01:16:35 +0100 (CET)
Received: from [10.255.64.11] (unknown [185.176.245.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: andre@tomt.net)
 by mail.ugh.no (Postfix) with ESMTPSA id 7E26F24EA64;
 Wed, 12 Feb 2020 01:16:35 +0100 (CET)
Subject: Re: [PATCH v1] xprtrdma: Fix DMA scatter-gather list mapping imbalance
To: Chuck Lever <chuck.lever@oracle.com>
References: <158145102079.515252.3226617475691911684.stgit@morisot.1015granger.net>
 <8781b043-74a6-4ee0-d1c9-46f797b4aec2@tomt.net>
 <DC2EEB01-5C19-4FB5-B103-D9ADF09E07FA@oracle.com>
From: Andre Tomt <andre@tomt.net>
Message-ID: <a8789f8a-9574-b032-3f6c-8d2d2ee74b34@tomt.net>
Date: Wed, 12 Feb 2020 01:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DC2EEB01-5C19-4FB5-B103-D9ADF09E07FA@oracle.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org
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

On 11.02.2020 23:00, Chuck Lever wrote:
> Hi Andre, thanks for trying this out.
> 
>> On Feb 11, 2020, at 3:50 PM, Andre Tomt <andre@tomt.net> wrote:
>>
>> On 11.02.2020 20:58, Chuck Lever wrote:
>>> The @nents value that was passed to ib_dma_map_sg() has to be passed
>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
>>> concatenate sg entries, it will return a different nents value than
>>> it was passed.
>>> The bug was exposed by recent changes to the AMD IOMMU driver.
>>
>> This seems to fail differently on my system; mount fails with:
>> mount.nfs: mount system call failed
>>
>> and the kernel log reports:
>> [   38.890344] NFS: Registering the id_resolver key type
>> [   38.890351] Key type id_resolver registered
>> [   38.890352] Key type id_legacy registered
>> [   38.901799] NFS: nfs4_discover_server_trunking unhandled error -5. Exiting with error EIO
>> [   38.901817] NFS4: Couldn't follow remote path
>>
>> amd_iommu=off still works
>>
>> One detail I accidentally left out of the original report is that the server (intel system) is running Ubuntu 20.04 ("beta") userspace, and AMD clients are Ubuntu 19.10 userspace. Although I dont believe this to matter at this point.
> 
> Next thing to try:
> 
> # trace-cmd record -e sunrpc -e rpcrdma
> 
> then issue the mount command. Once it completes, ^C the trace-cmd and send me trace.dat.
> 
> Try this with both the v5.4 kernel and the v5.5 kernel (and note that trace-cmd overwrites trace.dat, so copy it out between tests).

I've uploaded them to https://tomt.net/temp/rdmaiommubug/
I'll probably do a 5.5.3 with the v1 fix as well, should show up 
momentarily.

>>> Reported-by: Andre Tomt <andre@tomt.net>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Fixes: 1f541895dae9 ("xprtrdma: Don't defer MR recovery if ro_map fails")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/frwr_ops.c |    5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>> Hey Andre, please try this out. It just reverts the bit of brokenness that
>>> Robin observed this morning. I've done basic testing here with Intel
>>> IOMMU systems, no change in behavior (ie, all good to go).
>>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
>>> index 095be887753e..449bb51e4fe8 100644
>>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>>> @@ -313,10 +313,9 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>>>   			break;
>>>   	}
>>>   	mr->mr_dir = rpcrdma_data_dir(writing);
>>> +	mr->mr_nents = i;
>>>   -	mr->mr_nents =
>>> -		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
>>> -	if (!mr->mr_nents)
>>> +	if (!ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir))
>>>   		goto out_dmamap_err;
>>>     	ibmr = mr->frwr.fr_mr;
>>
> 
> --
> Chuck Lever
> 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
