Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3012FA372C
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA48721D7F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ZKTAliY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA48721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D121E9C;
	Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F91DDAF
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:47:36 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 29C0B8C7
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:47:35 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8C2D621882;
	Fri,  8 Nov 2019 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573231655;
	bh=cs+B3yBrSuaAZXL4uv8XzM+V7pyVqJSiFSP8eVhd1EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ZKTAliYefLOXM89fFk6VfR6ZAhxURhObP0x1v8/X3wN4FqrZMSDSCosI/M4v4Wv1
	IJrlwqP6AAsJZfvSyKWILkCfqkEzkmD3z2YPLvczvMO7S55ZLcd5AJkKrJrp3lJftg
	iJffAEbRSwFQ1JO91ch7fPeGEgnVa572cgcaWeMo=
Date: Fri, 8 Nov 2019 16:47:30 +0000
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
	explicitly non-modular"
Message-ID: <20191108164728.GB20866@willie-the-truck>
References: <20191108151608.20932-1-will@kernel.org>
	<20191108151608.20932-7-will@kernel.org>
	<06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
	<7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Nov 08, 2019 at 04:44:25PM +0000, John Garry wrote:
> On 08/11/2019 16:17, John Garry wrote:
> > On 08/11/2019 15:16, Will Deacon wrote:
> > > +MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> > =

> > Hi Will,
> > =

> > > =A0 static struct platform_driver arm_smmu_driver =3D {
> > > =A0=A0=A0=A0=A0 .driver=A0=A0=A0 =3D {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0=A0=A0=A0=A0=A0 =3D "arm-smmu-=
v3",
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table=A0=A0=A0 =3D of_match_ptr=
(arm_smmu_of_match),
> > > -=A0=A0=A0=A0=A0=A0=A0 .suppress_bind_attrs =3D true,
> > =

> > Does this mean that we can now manually unbind this driver from the SMMU
> > device?
> > =

> > Seems dangerous. Here's what happens for me:
> > =

> > root@ubuntu:/sys# cd ./bus/platform/drivers/arm-smmu-v3
> > ind @ubuntu:/sys/bus/platform/drivers/arm-smmu-v3# echo
> > arm-smmu-v3.0.auto > unbind
> > [=A0=A0 77.580351] hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) fo=
und!
> > ho [=A0=A0 78.635473] platform arm-smmu-v3.0.auto: CMD_SYNC timeout at
> > 0x00000146 [hwprod 0x00000146, hwcons 0x00000000]
> > =

> > > =A0=A0=A0=A0=A0 },
> > > =A0=A0=A0=A0=A0 .probe=A0=A0=A0 =3D arm_smmu_device_probe,
> > > +=A0=A0=A0 .remove=A0=A0=A0 =3D arm_smmu_device_remove,
> > > =A0=A0=A0=A0=A0 .shutdown =3D arm_smmu_device_shutdown,
> > > =A0 };
> > > -builtin_platform_driver(arm_smmu_driver);
> > > +module_platform_driver(arm_smmu_driver);
> > > +
> =

> BTW, it now looks like it was your v1 series I was testing there, on your
> branch iommu/module. It would be helpful to update for ease of testing.

Yes, sorry about that. I'll update it now (although I'm not sure it will
help with this -- I was going to see what happens with other devices such
as the intel-iommu or storage controllers)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
