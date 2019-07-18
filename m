Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6F4C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 20:26:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025B221019
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 20:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025B221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BEF371E2B;
	Thu, 18 Jul 2019 20:26:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 031021D8E
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 20:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from impout009.msg.chrl.nc.charter.net
	(impout009aa.msg.chrl.nc.charter.net [47.43.20.33])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4586F887
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 20:26:14 +0000 (UTC)
Received: from [10.10.100.101] ([24.236.195.206]) by cmsmtp with ESMTPA
	id oCyiheBYfiYmuoCyihrjhs; Thu, 18 Jul 2019 20:26:13 +0000
Authentication-Results: charter.net; none
X-Authority-Analysis: v=2.3 cv=S41tP7kP c=1 sm=1 tr=0
	a=mQKZifbrf9Y32dM5lNTaRA==:117 a=mQKZifbrf9Y32dM5lNTaRA==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=3fyaaF4VAAAA:8
	a=zd2uoN0lAAAA:8 a=DAWNvU-7WsZP1TvUpVoA:9 a=QEXdDO2ut3YA:10
	a=jOuFdahVONy5WApiBME_:22
From: Al Farleigh <AWFour@charter.net>
Subject: Re: x86-64 kernel dma issue; bisected
To: Christoph Hellwig <hch@infradead.org>
References: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
	<20190718093129.GA25126@infradead.org>
Message-ID: <93c60ba2-44d3-25ce-b174-137a9eed7831@charter.net>
Date: Thu, 18 Jul 2019 16:26:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718093129.GA25126@infradead.org>
Content-Language: en-US
X-CMAE-Envelope: MS4wfHJK2ZN5Cj3oRtlzCGBXcm4dxbJdcQokxUu6y6xb1ebvrqnGPDBurCkJ3bZaw5ClY72+fQjIpSVxBrWxVtTKp5+DHpe9fBX8rgPw6QpxvjgxAamk5KkY
	tWr5Gd1Idpyb4zaiFnq1okCT8P+cc8peA2ppHH2zUsDHnKiMhfKw3yfjVF5rk0Om3CQgBJTaFNbcxdRmkbYea8/6VzqxV+6eXsT3P8dZ+U+x/JS6PXbI4FmM
	dpbwQWUA2wX9cEiuy7K10Q==
Cc: Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org
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

On 7/18/19 5:31 AM, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 10:43:33PM -0400, Al Farleigh wrote:
>> re: the dma-direct code commit below
>>
>> I have bisected the kernel to isolate a PCI board problem on my AMD x86-64
>> ASROCK system. The board worked at (Fedora kernel) 4.18.16 but stopped when
>> moving to (Fedora kernel) 5.0. I then used (git/torvalds/linux) 4.20-rc4 or
>> so to locate the fault via bisect.
>>
>> I now have two kernels, good/bad, that straddle the commit.
>>
>> I was asked to try v5.2 just in case it was fixed; I compiled it and the
>> fault appears to still be present.
>>
>> Simply, mpeg video does not stream from board; no errors, but no video.
>>
>> My work is documented at
>> https://bugs.kde.org/show_bug.cgi?id=408004
> 
> I've looked through that log but I'm still not sure what driver
> you are actually using for video capture.  Am I right in that your
> are using the saa7134 driver based on the dmesg?
> 
> That driver uses a 32-bit DMA mask, so we should be bounce buffering.
> 
> We recently had a bug with the AMD memory encryption and the encrypted
> bit, are you using that?  The "Freeing unused decrypted memory:" message
> somehow suggests that but I can't find where that would come from by a
> simple grep.  If your are using AMD memory encryption or are not sure
> please try the patch below:
> 

Hello; I installed the patch on v5.2, verified by eye it got applied, 
recompiled, and found no change; that is, the video stream doesn't display.

I also went back and verified my known good v4.20-rc4 kernel still 
worked, and my known bad v4.20-rc4 stayed bad. No changes.

I will note that the video has once or twice but extremely rarely had 
started on the bad kernels; maybe a timing or race, or somehow being set 
up from a previous boot; I try to power off between tests to make sure 
system starts from a known, uncontaminated environment.

Regards, Al Farleigh


> ---
>>From 9087c37584fb7d8315877bb55f85e4268cc0b4f4 Mon Sep 17 00:00:00 2001
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Wed, 10 Jul 2019 19:01:19 +0000
> Subject: dma-direct: Force unencrypted DMA under SME for certain DMA masks
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
