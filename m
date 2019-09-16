Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52258C49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:46:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17052206A4
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iOrWK8Kv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="duPxUEPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17052206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF45D138D;
	Mon, 16 Sep 2019 09:46:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 39BAD1385
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:46:24 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA6408AC
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 09:46:23 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 56CB461242; Mon, 16 Sep 2019 09:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627183;
	bh=ml5rnkJTMHmPAf4IGrPXykOFxktm7Cfyo+9yeKBWpwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iOrWK8KvjKd9V21orXv8LCh/tnu+nuKuaYKr/q/fGuhB0y9YpTskjJxkqIrZGh9vb
	BdBEFfPkJC2NPsq4KEKfMuimbwDKQEhTnyExKF1tNIrwgBIXevvfwIzUADs1zHDUV4
	iu6sS/2mKQvr+2UY1GRE2fIJRRnReXc6pb2kAGfY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5706A61214;
	Mon, 16 Sep 2019 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1568627181;
	bh=ml5rnkJTMHmPAf4IGrPXykOFxktm7Cfyo+9yeKBWpwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=duPxUEPSEzsjcd7nUgQV8fgJSXBkiT6J8pqvO54GDG/emEJ+jVACz8NLsJMWGlR9+
	y+ADWRpCf3SPpOFfmxcpB7CASL6Ke+6SfUrKjmSubwc6x7ResMTm/M4kh4iqYKhVQZ
	UiMCWrafX6sUll0VyrqcEmuFM4EN8/SB6egdgZwM=
MIME-Version: 1.0
Date: Mon, 16 Sep 2019 15:16:21 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
	hook
In-Reply-To: <9fb7d18c-e292-cbc9-aa6d-d85465ea249e@arm.com>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-4-vivek.gautam@codeaurora.org>
	<9fb7d18c-e292-cbc9-aa6d-d85465ea249e@arm.com>
Message-ID: <f234e891bc16a1869ba8a929e52a49f7@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org, agross@kernel.org,
	linux-arm-msm-owner@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Robin,

On 2019-09-10 18:56, Robin Murphy wrote:
> On 23/08/2019 07:32, Vivek Gautam wrote:
>> Add reset hook for sdm845 based platforms to turn off
>> the wait-for-safe sequence.
>> 
>> Understanding how wait-for-safe logic affects USB and UFS performance
>> on MTP845 and DB845 boards:
>> 
>> Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
>> to address under-performance issues in real-time clients, such as
>> Display, and Camera.
>> On receiving an invalidation requests, the SMMU forwards SAFE request
>> to these clients and waits for SAFE ack signal from real-time clients.
>> The SAFE signal from such clients is used to qualify the start of
>> invalidation.
>> This logic is controlled by chicken bits, one for each - MDP 
>> (display),
>> IFE0, and IFE1 (camera), that can be accessed only from secure 
>> software
>> on sdm845.
>> 
>> This configuration, however, degrades the performance of non-real time
>> clients, such as USB, and UFS etc. This happens because, with 
>> wait-for-safe
>> logic enabled the hardware tries to throttle non-real time clients 
>> while
>> waiting for SAFE ack signals from real-time clients.
>> 
>> On mtp845 and db845 devices, with wait-for-safe logic enabled by the
>> bootloaders we see degraded performance of USB and UFS when kernel
>> enables the smmu stage-1 translations for these clients.
>> Turn off this wait-for-safe logic from the kernel gets us back the 
>> perf
>> of USB and UFS devices until we re-visit this when we start seeing 
>> perf
>> issues on display/camera on upstream supported SDM845 platforms.
>> The bootloaders on these boards implement secure monitor callbacks to
>> handle a specific command - QCOM_SCM_SVC_SMMU_PROGRAM with which the
>> logic can be toggled.
>> 
>> There are other boards such as cheza whose bootloaders don't enable 
>> this
>> logic. Such boards don't implement callbacks to handle the specific 
>> SCM
>> call so disabling this logic for such boards will be a no-op.
>> 
>> This change is inspired by the downstream change from Patrick Daly
>> to address performance issues with display and camera by handling
>> this wait-for-safe within separte io-pagetable ops to do TLB
>> maintenance. So a big thanks to him for the change and for all the
>> offline discussions.
>> 
>> Without this change the UFS reads are pretty slow:
>> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
>> 10+0 records in
>> 10+0 records out
>> 10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
>> real    0m 22.39s
>> user    0m 0.00s
>> sys     0m 0.01s
>> 
>> With this change they are back to rock!
>> $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
>> 300+0 records in
>> 300+0 records out
>> 314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
>> real    0m 1.03s
>> user    0m 0.00s
>> sys     0m 0.54s
>> 
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu-impl.c | 27 ++++++++++++++++++++++++++-
> 
> I'd be inclined to introduce the inevitable arm-smmu-qcom.c from the
> start, and save worrying about moving this out later. Other than that,
> though, the general self-contained shape of it all is every bit as
> beautiful as I'd hoped :D
> 

Have posted v5 with your suggestion.

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
