Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B4C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 10:50:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3993F2222A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 10:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3993F2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sect.tu-berlin.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 650C486E4A;
	Tue, 15 Dec 2020 10:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYPizr6K2Ybe; Tue, 15 Dec 2020 10:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EED7D86DF2;
	Tue, 15 Dec 2020 10:50:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9F6BC0893;
	Tue, 15 Dec 2020 10:50:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3E4DC013B;
 Tue, 15 Dec 2020 10:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A315986CA7;
 Tue, 15 Dec 2020 10:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZIdHP9pWFFh; Tue, 15 Dec 2020 10:50:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C8A186C7C;
 Tue, 15 Dec 2020 10:50:35 +0000 (UTC)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain
 [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id A184E7E0835_FD894F8B;
 Tue, 15 Dec 2020 10:50:32 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "exchange.tu-berlin.de",
 Issuer "DFN-Verein Global Issuing CA" (verified OK))
 by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id
 D91109421A4_FD894F7F; Tue, 15 Dec 2020 10:50:31 +0000 (GMT)
Received: from [192.168.1.8] (91.64.84.74) by ex-02.tubit.win.tu-berlin.de
 (172.26.26.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5; Tue, 15 Dec 2020
 11:50:31 +0100
Subject: Re: swiotlb/virtio: unchecked device dma address and length
To: Ashish Kalra <ashish.kalra@amd.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <20201215084720.GA9981@ashkalra_ubuntu_server>
From: Felicitas Hetzelt <file@sect.tu-berlin.de>
Message-ID: <c90f5ea4-b8b2-98d7-546a-dc71fb618230@sect.tu-berlin.de>
Date: Tue, 15 Dec 2020 11:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201215084720.GA9981@ashkalra_ubuntu_server>
Content-Language: en-US
X-ClientProxiedBy: ex-05.tubit.win.tu-berlin.de (172.26.26.166) To
 ex-02.tubit.win.tu-berlin.de (172.26.26.163)
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de;
 h=subject:to:cc:references:from:message-id:date:mime-version:in-reply-to:content-type:content-transfer-encoding;
 s=dkim-tub; bh=+Z8MMNsCpkE+esRTJwMj0LtKju3/zh/XRU0i34kFPnY=;
 b=LF2v7WuYtv0ur2iphq2AJg39ceV04KXglD90YtUtLpwHjNMWGgTuoHLls2HbizRdTe/gwiFNoh12Yp8PLvWO6ESknN2vwr8MmiR8KDLQZLbglJGKyQ4vhQmoAcJ/skr0Zwe0UK7gmf2BKiNk9xjZEKaIKX8Tm5oh65FZ6KOU1ho=
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, "Radev,
 Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jon.Grimm@amd.com, virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

Hello,
thank you all for looking into this! To answer some of the questions:
 - Did you have already some PoC fixes for this:
   We don't have a full PoC or fix currently. Thought we have a PoC
   with which were able to overwrite memory outside of the mapped
   dma region.
 - Is there a CVE associated with this?
   No
 - Is there a paper on this you all are working on?
   Yes, we were planning to use this bug (among others
   in a paper)

Could you point us to the intel thunder issue that you mentioned?

On 12/15/20 9:47 AM, Ashish Kalra wrote:
> On Mon, Dec 14, 2020 at 04:49:50PM -0500, Konrad Rzeszutek Wilk wrote:
>> On Fri, Dec 11, 2020 at 06:31:21PM +0100, Felicitas Hetzelt wrote:
>>> Hello,
>>
>> Hi! Please see below my responses.
>>
>>> we have been analyzing the Hypervisor-OS interface of Linux
>>> and discovered bugs in the swiotlb/virtio implementation that can be
>>> triggered from a malicious Hypervisor / virtual device.
>>> With SEV, the SWIOTLB implementation is forcefully enabled and would
>>> always be used. Thus, all virtio devices and others would use it under
>>> the hood.
>>>
>>> The reason for analyzing this interface is that, technologies such as
>>> Intel's Trusted Domain Extensions [1] and AMD's Secure Nested Paging [2]
>>> change the threat model assumed by various Linux kernel subsystems.
>>> These technologies take the presence of a fully malicious hypervisor
>>> into account and aim to provide protection for virtual machines in such
>>> an environment. Therefore, all input received from the hypervisor or an
>>> external device should be carefully validated. Note that these issues
>>> are of little (or no) relevance in a "normal" virtualization setup,
>>> nevertheless we believe that it is required to fix them if TDX or SNP is
>>> used.
>>>
>>> We are happy to provide more information if needed!
>>>
>>> [1]
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fwww%2Fus%2Fen%2Fdevelop%2Farticles%2Fintel-trust-domain-extensions.html&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=THAJlYGLSOx3bKQYH62TLKH50By7Wnsu0z92snfNY84%3D&amp;reserved=0
>>>
>>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fen%2Fprocessors%2Famd-secure-encrypted-virtualization&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M3jmYCWaEvmAzIy%2F4z5XstsPf812SbEkuNX5PVVr0HY%3D&amp;reserved=0
>>>
>>> Bug:
>>> OOB memory write.
>>> dma_unmap_single -> swiotlb_tbl_unmap_single is invoked with dma_addr
>>> and length parameters that are under control of the device.
>>> This happens e.g. in virtio_ring:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.10-rc7%2Fsource%2Fdrivers%2Fvirtio%2Fvirtio_ring.c%23L378&amp;data=04%7C01%7Cashish.kalra%40amd.com%7C1d1cbca182a84c0e504708d8a079eec0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435792867090126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=j0CIi%2F8hBkVx45XGBtT4Ri52uWIOdOts%2BSbJ0kCB5B0%3D&amp;reserved=0
>>
>> Heya!
>>
>> Thank you for pointing this out! I've a couple of questions and hope you can
>> help me out with them.
>>
>> Also CC-ing AMD / TDX folks.
>>>
> 
> Adding more relevant folks in AMD.
> 
> Needless to say, the swiotlb code needs to validate this external untrusted input dma_addr and length parameters.
> 
> Thanks,
> Ashish
> 
>>> This raises two issues:
>>> 1) swiotlb_tlb_unmap_single fails to check whether the index generated
>>> from the dma_addr is in range of the io_tlb_orig_addr array.
>>
>> That is fairly simple to implement I would think. That is it can check
>> that the dma_addr is from the PA in the io_tlb pool when SWIOTLB=force
>> is used.
>>
>>> 2) when swiotlb_bounce is called the device controls the length of the
>>> memory copied to the cpu address.
>>
>> So.. this sounds very similar to the Intel Thunder.. something issue
>> where this exact issue was fixed by handing the DMA off to the SWIOTLB
>> bounce code.
>>
>> But if that is broken, then that CVE is still not fixed?
>>
>> So the issue here is that swiotlb_tbl_unmap_single(..,mapping_size,) is
>> under the attacker control. Ugh.
>>
>> One way could be to have a io_tlb_orig_addr-ish array with the length
>> of mappings to double check?
>>
>> Couple more questions:
>>  - Did you have already some PoC fixes for this? 
>>  - Is there a CVE associated with this?
>>  - Is there a paper on this you all are working on?
>>
>> Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
