Return-Path: <SRS0=F1RC=PL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1CEC433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Oct 2021 08:41:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B540860EBD
	for <iommu@archiver.kernel.org>; Sat, 23 Oct 2021 08:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B540860EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 790BA81C26;
	Sat, 23 Oct 2021 08:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwFHWXigfXiG; Sat, 23 Oct 2021 08:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49A4381C21;
	Sat, 23 Oct 2021 08:41:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28218C0019;
	Sat, 23 Oct 2021 08:41:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64FADC000E
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 08:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40B5181947
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 08:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bu9ON4tyoTLt for <iommu@lists.linux-foundation.org>;
 Sat, 23 Oct 2021 08:41:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 014DF8184F
 for <iommu@lists.linux-foundation.org>; Sat, 23 Oct 2021 08:41:02 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 566015811DA;
 Sat, 23 Oct 2021 04:41:00 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute1.internal (MEProxy); Sat, 23 Oct 2021 04:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=Htu9AO5gl+n1c9jNH3Bn1cOXdIej
 w7xzqEpD55cSfzg=; b=Q6+SuvrVUVFeBg4P5BOp4zp5Z/o9bwIWLN+YQQa9IRCN
 n7Jo7wcyGz0KlqVqRb4mvupSgriK2oMdPCxE7RD/Z+Ho6Ap53LmT28PvJb8GFIXq
 nsx2i+ldFDdgIGbH4+A7/gsUeXWJBpyEbYVSDUPmVUvYyJMOAVCwO1JmqlkivFyo
 w2BG6gMWVPo5CRc0kNShYcFVNLcXZTaVL1UbuLRw9LwJlYm3g3kbEotzOjtjqixk
 VUrgJ2TRQyzT/a3RJ2VkIgHZq/ss0sLCyaTuWf2RpWrpN1XwqSOVhYXbqTBddpES
 0hSc8uM0VWadWuBbdItZWrdYVpOthICB3KAuu5SI5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Htu9AO
 5gl+n1c9jNH3Bn1cOXdIejw7xzqEpD55cSfzg=; b=V6zr29oJ1TLSZVVUbI5gdZ
 IDgbKcTBSn9QZjr41lkhw3kja2Jq7GsnDpGvLFBvpoPA9Sw6sX2J78/atCTDOLHf
 ihS8UbZ8PoR9/Kl9YysFcGXaTCgRQb/3zjN2HdS3lYbgfCMPU0HaAXmpBXauF+9v
 avbBRWXur6peL/XGHZHx+kdhci0gLRz6bXsYFL/28Ee5LlHTEhhGnAxLZxFbge1p
 PjbTGvrimgG10GFHAVIAR9i8tPHq0cYcnei+qsrjffsbZfA/rNUPPROI8gPStyZD
 Q5uX0kBuYOBRHcEMhuyS9D821orES9KUK3XayF8R5u+uX+vooJgJoSHrF8H8WpZw
 ==
X-ME-Sender: <xms:mspzYTRkeQ7wKB7GlLGLksfPOHY56x-bFpgWAvT3oDqVr5Ivyv_L5g>
 <xme:mspzYUx-nPkaUiazQ045f9sbwKeIS3ZQT2AX2bWRyne2DNUZcAbSafb6mCsXXLG0D
 oEvQJg1ExTWR4tIhD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeftddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:mspzYY1mii5m75ei5bwxg1aj516yt1Ladt8tfp8y2_cMovDHueMIFQ>
 <xmx:mspzYTDE7z34NRiMuPMWFtPmqCu5OHc1J_YqhngZLA4qjQbK3aWFgQ>
 <xmx:mspzYchs3YGSTIR4tXTUctLBCxAFAdB3u5p-pQCgYei9uq2Yv9Kk9A>
 <xmx:nMpzYVUMhHVmqA8mvLKCHDedHhGsYi8Fz0_4C-kxd7hJZMGYA_ZqVg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5AFB92740063; Sat, 23 Oct 2021 04:40:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <f5941a9c-d1e0-4603-becf-b06273ac01df@www.fastmail.com>
In-Reply-To: <ccc3c517-fa3a-6866-e139-5b3983080e6c@arm.com>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
 <8735ovdbcv.wl-maz@kernel.org>
 <6a886030-cbc6-9e92-bf79-77b659da2915@linux.intel.com>
 <87wnm6bxx2.wl-maz@kernel.org>
 <106088e3-2928-dace-e1b6-e1e74ffec366@linux.intel.com>
 <87pmrxbi0v.wl-maz@kernel.org> <ccc3c517-fa3a-6866-e139-5b3983080e6c@arm.com>
Date: Sat, 23 Oct 2021 10:40:38 +0200
To: "Robin Murphy" <robin.murphy@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On Fri, Oct 22, 2021, at 15:39, Robin Murphy wrote:
> On 2021-10-22 09:06, Marc Zyngier wrote:
>> On Fri, 22 Oct 2021 03:52:38 +0100,
>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>
>>> On 10/21/21 4:10 PM, Marc Zyngier wrote:
>>>> On Thu, 21 Oct 2021 03:22:30 +0100,
>>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>
>>>>> On 10/20/21 10:22 PM, Marc Zyngier wrote:
>>>>>> On Wed, 20 Oct 2021 06:21:44 +0100,
>>>>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>>>
>>>>>>> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>>>>>>>> +	/*
>>>>>>>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>>>>>>>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>>>>>>>> +	 * only limit domain->pgsize_bitmap after having attached the first
>>>>>>>> +	 * device.
>>>>>>>> +	 */
>>>>>>>> +	ret = iommu_check_page_size(domain);
>>>>>>>> +	if (ret) {
>>>>>>>> +		__iommu_detach_device(domain, dev);
>>>>>>>> +		return ret;
>>>>>>>> +	}
>>>>>>>
>>>>>>> It looks odd. __iommu_attach_device() attaches an I/O page table for a
>>>>>>> device. How does it relate to CPU pages? Why is it a failure case if CPU
>>>>>>> page size is not covered?
>>>>>>
>>>>>> If you allocate a CPU PAGE_SIZE'd region, and point it at a device
>>>>>> that now can DMA to more than what you have allocated because the
>>>>>> IOMMU's own page size is larger, the device has now access to data it
>>>>>> shouldn't see. In my book, that's a pretty bad thing.
>>>>>
>>>>> But even you enforce the CPU page size check here, this problem still
>>>>> exists unless all DMA buffers are PAGE_SIZE aligned and sized, right?
>>>>
>>>> Let me take a CPU analogy: you have a page that contains some user
>>>> data *and* a kernel secret. How do you map this page into userspace
>>>> without leaking the kernel secret?
>>>>
>>>> PAGE_SIZE allocations are the unit of isolation, and this applies to
>>>> both CPU and IOMMU. If you have allocated a DMA buffer that is less
>>>> than a page, you then have to resort to bounce buffering, or accept
>>>> that your data isn't safe.
>>>
>>> I can understand the problems when IOMMU page sizes is larger than CPU
>>> page size. But the code itself is not clean. The vendor iommu drivers
>>> know more hardware details than the iommu core. It looks odd that the
>>> vendor iommu says "okay, I can attach this I/O page table to the
>>> device", but the iommu core says "no, you can't" and rolls everything
>>> back.
>> 
>> If your IOMMU driver can do things behind the core's back and
>> contradict the view that the core has, then it is probably time to fix
>> your IOMMU driver and make the core aware of what is going on.
>> Supported page sizes is one of these things.
>> 
>> In general, keeping the IOMMU driver as dumb as possible is a worthy
>> design goal, and this is why we have these abstractions.
>
> In this case it's the abstractions that are the problem, though. Any 
> driver which supports heterogeneous IOMMU instances with potentially 
> differing page sizes currently has no choice but to do horrible bodges 
> to make the bus-based iommu_domain_alloc() paradigm work *at all*. 
> Fixing that from the fundamental API level upwards has been on the to-do 
> list for some time now, but won't be straightforward.

That does sound like a rather big change.

But it also sounds like I can just limit DART to 16K pages for now and
kick the problem down the road until either Apple decides to do DARTs with
heterogeneous page sizes again or until those changes are done :-)

That at least gets rid of the weird atttach/check/maybe-detach-again hack
here.


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
