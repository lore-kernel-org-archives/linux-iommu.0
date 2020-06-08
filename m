Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F8C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC6F206C3
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gabxL+y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC6F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF40585D6E;
	Mon,  8 Jun 2020 09:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jLVtEDl4pD1; Mon,  8 Jun 2020 09:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6357F85B4D;
	Mon,  8 Jun 2020 09:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D32AC07FF;
	Mon,  8 Jun 2020 09:13:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F883C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 09:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 85E0F86614
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 09:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w+ndJz0gUjuo for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 09:13:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8D03586581
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 09:13:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591607597; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GhhsEMufI8UvffSMZZKH6Z/KWhXYBPW2V1EIJtJ4Olg=;
 b=gabxL+y3W3Grx2yuE/2Pwb+icJ3NSI/COnkWjViilcXwpEGAmzGmJBRRRnndmw80nrbQrXAb
 VpTQtMEne59eRfkKxzXx17rYdGUzHZXck+1yV5H/CQCx8KPUQ6FmhEFmxpPKiESzZcuiUWiA
 SYGtCztmix/iCWcWZfiWjyd9n2o=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ede0120cea6afef5fddb449 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 09:13:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E5857C43387; Mon,  8 Jun 2020 09:13:03 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 219B3C433C6;
 Mon,  8 Jun 2020 09:13:03 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 08 Jun 2020 14:43:03 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
In-Reply-To: <20200608081846.GA1542@willie-the-truck>
References: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
 <20200608081846.GA1542@willie-the-truck>
Message-ID: <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Will,

On 2020-06-08 13:48, Will Deacon wrote:
> On Sun, Jun 07, 2020 at 04:39:18PM +0530, Sai Prakash Ranjan wrote:
>> Remove SMMU shutdown callback since it seems to cause more
>> problems than benefits. With this callback, we need to make
>> sure that all clients/consumers of SMMU do not perform any
>> DMA activity once the SMMU is shutdown and translation is
>> disabled. In other words we need to add shutdown callbacks
>> for all those clients to make sure they do not perform any
>> DMA or else we see all kinds of weird crashes during reboot
>> or shutdown. This is clearly not scalable as the number of
>> clients of SMMU would vary across SoCs and we would need to
>> add shutdown callbacks to almost all drivers eventually.
>> This callback was added for kexec usecase where it was known
>> to cause memory corruptions when SMMU was not shutdown but
>> that does not directly relate to SMMU because the memory
>> corruption could be because of the client of SMMU which is
>> not shutdown properly before booting into new kernel. So in
>> that case, we need to identify the client of SMMU causing
>> the memory corruption and add appropriate shutdown callback
>> to the client rather than to the SMMU.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 6 ------
>>  drivers/iommu/arm-smmu.c    | 6 ------
>>  2 files changed, 12 deletions(-)
> 
> This feels like a giant bodge to me and I think that any driver which
> continues to perform DMA after its ->shutdown() function has been 
> invoked
> is buggy. Wouldn't that cause problems with kexec(), for example?
> 

Yes it is definitely a bug in the client driver if DMA is performed
after shutdown callback of that respective driver is invoked and it must
be fixed in that driver. But here the problem I was describing is not 
that,
most of the drivers do not have a shutdown callback to begin with and 
adding
it just because of shutdown dependency on SMMU doesn't seem so well 
because
we can have many more such clients in the future and then we have to 
just go
on adding the shutdown callbacks everywhere.

> There's a clear shutdown dependency ordering, where the clients of the
> SMMU need to shutdown before the SMMU itself, but that's not really
> the SMMU driver's problem to solve.
> 

The problem with kexec may not be directly related to SMMU as you said
above if DMA is performed after the client shutdown callback, then its a
bug in the client driver, so that needs to be fixed in the client 
driver,
not the SMMU. So is there any point in having the SMMU shutdown 
callback?
As you see, with this SMMU shutdown callback, we need to add shutdown
callbacks in all the client drivers.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
