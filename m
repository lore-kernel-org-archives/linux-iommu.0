Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30CC43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 13:55:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9B5218AC
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 13:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="I9EzaqNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9B5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E61FD203F9;
	Thu, 19 Dec 2019 13:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp2nIMSdOnOq; Thu, 19 Dec 2019 13:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 128E9203C9;
	Thu, 19 Dec 2019 13:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED1A8C18DC;
	Thu, 19 Dec 2019 13:54:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B493C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 13:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 67EEC203F9
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 13:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5laHE2SGqlJ for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 13:54:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 55540203C9
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576763693;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=kI2ukjRy7KCFsfSWtfjMgsGPbi2sbVneeGOg1X7LIV8=;
 b=I9EzaqNJHOW94rgUr45Ri+W4i2OpRHfjdpPfuSmsxVEPI0sZUdtLPQbTuCos00/aM7
 RWDnnAJvLGyDO3v8hEPK7FUc32f8lHlwemx40pQlIPU/TFPP/2qs5+CAMcYBAdHHBvV8
 5Km3wwztogCN4SzyW117ra78kYjdvXqHBdCwhcuz9N+enPUx6x0eKWcCCwbnvlCCbgkg
 CduXNTN0dhT+JpE45ueINpYAvy6guJfSKyvRLM0NZRqfigr1leyFrMO/hgs/ijC04anf
 R4wvwD0L877nuNoKj4NKaBLx4/zvp9lr21MTSHqBnJtH9HteX5FS2iPoDi0eOEGGIasN
 NPfA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIk4IhhIsapUrtwdiemkXf6zUCQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:141e:1690:4104:28ad]
 by smtp.strato.de (RZmta 46.1.1 AUTH) with ESMTPSA id 40080evBJDsS14t
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 19 Dec 2019 14:54:28 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Message-ID: <ea5433f6-ef8d-3cd0-0645-dd89c4806dca@xenosoft.de>
Date: Thu, 19 Dec 2019 14:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 mad skateman <madskateman@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 "contact@a-eon.com" <contact@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 linuxppc-dev@lists.ozlabs.org
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

Hi All,

We still have some issues with PCI cards in our FSL P5020 and P5040 
systems since the DMA mapping updates. [1, 2]

We have to limit the RAM to 3500MB for some problematic PCI cards. 
(kernel boot argument 'mem=3500M')

The problematic DMA mapping code was added with the PowerPC updates 
4.21-1 to the official kernel source code last year. [3]

We have created a bug report. [4]

The old 4.x kernels aren't affected because they use the old DMA code.

Please check the new DMA code again.

Thanks,
Christian

[1] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&p=49486#p49486
[2] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=50#p49099
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d6973327ee84c2f40dd9efd8928d4a1186c96e2
[4] https://bugzilla.kernel.org/show_bug.cgi?id=205201


On 28 November 2018 at 4:55 pm, Christian Zigotzky wrote:
> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
>> Nothing specific yet.
>>
>> I'm a bit worried it might break one of the many old obscure platforms
>> we have that aren't well tested.
>>
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old 
> code works perfect. We must not forget, that we work for the end 
> users. Does the end user have advantages with this new code? Is it 
> faster? The old code works without any problems. I am also worried 
> about this code. How can I test this new DMA mapping code?
>
> Thanks
>
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
