Return-Path: <SRS0=kL4S=ZE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD8AC43331
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 23:04:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9334720674
	for <iommu@archiver.kernel.org>; Tue, 12 Nov 2019 23:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="RPBtP62q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9334720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4C508CC8;
	Tue, 12 Nov 2019 23:04:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5B84BCAF
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 23:04:27 +0000 (UTC)
X-Greylist: delayed 00:05:51 by SQLgrey-1.7.6
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
	[81.169.146.166])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 45B028AD
	for <iommu@lists.linux-foundation.org>;
	Tue, 12 Nov 2019 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573599864;
	s=strato-dkim-0002; d=xenosoft.de;
	h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=l6LnXidqFjF8wEu13TNhLe3TegTl/p6HTykS60F7XJ0=;
	b=RPBtP62qUTf4ywurz7NdItTGrSxtPBp1GrjuyodEQtZxvrJ1wY7hXE/qZ1P1tE/79S
	5Hylj8NOWOJTygKsHxjwZF6/9m5Ar8gLwD1RDA6/HTl3jWmKH60Z/ksTvHu8+OUxdq8r
	qifRUVmPAoXYAKRCse4t+Y0QY18TsKWjKJvHJqj07MrQhwMf3Me6V5gv4TXRTy/TvqbN
	uI9ggRwW/8w4azueXhLVSEimLIQWKQ3sb/RJHSdj4WFqLWVv6ica/9XOKenINu1w8Anp
	mX51xo63l+o0baNm6p7HGlfe1RnEF3a6dU8BahGo2pGd2m6SOrTrXVjSpvFgu35vpyKZ
	+UhA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhbLt/v7eF2q0hCA21Ezkix5/Bq7A=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:881b:29d1:ef56:a34c]
	by smtp.strato.de (RZmta 44.29.0 AUTH)
	with ESMTPSA id q007c8vACMwMiL6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Tue, 12 Nov 2019 23:58:22 +0100 (CET)
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
Message-ID: <288d3c11-725b-ecdd-2495-b4a69aafb693@xenosoft.de>
Date: Tue, 12 Nov 2019 23:58:22 +0100
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
Here you are:

.config: https://bugzilla.kernel.org/attachment.cgi?id=285815

dmesg: https://bugzilla.kernel.org/attachment.cgi?id=285813

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
