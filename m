Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086DAC17447
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 10:14:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08DC204EC
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 10:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="R8jgXCLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08DC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7102B1157;
	Wed, 13 Nov 2019 10:14:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8212B1150
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 10:14:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
	[85.215.255.54])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D8265712
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573640067;
	s=strato-dkim-0002; d=xenosoft.de;
	h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=J7/OnwrZ9IrNVa3LANzeKLBHmUi2jZG0D6gUnLn+clU=;
	b=R8jgXCLQiDj0/dO7+mbRqBRC0vpB9aM2JQk3BmfGd1SBO/QCKv354XxMk7CpegA0E7
	tDABpXaHvnOv1lo+0BTxe0NJMBYJ0jVk/uRis+F9K0+p1b42uG9sxH0g73O1dIWHs4/4
	xjvA9IFyuIedsCN6lJxvHqnuRtrqDfMbCcd4/Jx/awN6ZTazQeJhFYQ9DmaS36h19/8R
	UaWMfulvF403Gyuq0Zmd7btVZoHKwbDHmvwtq/kVhFmjPfSf5gR5V9WjZ6ew3VHTPa60
	Bsiz3pAcGC/LOI6WEDESU1JCCwEXAF4/7AnwePdJghmZSg1og/apmK5MGEtTToVy7bSh
	oxsg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgFIzdVjkULP4r2k+hZ6iFmBbj9vw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:f53b:829e:4025:ce2b]
	by smtp.strato.de (RZmta 44.29.0 AUTH)
	with ESMTPSA id q007c8vADAEHlLm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Wed, 13 Nov 2019 11:14:17 +0100 (CET)
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
To: Christoph Hellwig <hch@lst.de>
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
	<46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
	<20191105162856.GA15402@lst.de>
	<2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
	<d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
	<af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
	<0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
	<a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
	<20191112144109.GA11805@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <9b14ca1b-2d5d-52b5-c7b4-0e637dbb1157@xenosoft.de>
Date: Wed, 13 Nov 2019 11:14:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191112144109.GA11805@lst.de>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net,
	mad skateman <madskateman@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, paulus@samba.org,
	rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
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

Hello Christoph,

I have found the issue. :-)

GFP_DMA32 was renamed to GFP_DMA in the PowerPC updates 4.21-1 in 
December last year.

Some PCI devices still use GFP_DMA32 (grep -r GFP_DMA32 *). I renamed 
GFP_DMA32 to GFP_DMA in the file 
"drivers/media/v4l2-core/videobuf-dma-sg.c". After compiling the RC7 of 
kernel 5.4 my TV card works again.

Cheers,
Christian


On 12 November 2019 at 3:41 pm, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
>> Now, I can definitely say that this patch does not solve the issue.
>>
>> Do you have another patch for testing or shall I bisect?
> I'm still interested in the .config and dmesg.  Especially if the
> board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
> place inside the powerpc arch code doing funny things with the
> bus_dma_mask, which Robin pointed out looks fishy.
>
>> Thanks,
>> Christian
> ---end quoted text---
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
