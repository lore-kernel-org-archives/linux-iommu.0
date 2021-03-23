Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6643C433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 15:53:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441A619BA
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441A619BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F247400BB;
	Tue, 23 Mar 2021 15:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XADEw0gg6GAs; Tue, 23 Mar 2021 15:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id E22DA400B8;
	Tue, 23 Mar 2021 15:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6DEDC000A;
	Tue, 23 Mar 2021 15:53:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 682A7C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 15:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5655483ED0
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 15:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6yVMNcrpbpAO for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 15:53:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B433D83EA8
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 15:53:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F1FD6E;
 Tue, 23 Mar 2021 08:53:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47EA3F718;
 Tue, 23 Mar 2021 08:53:41 -0700 (PDT)
Date: Tue, 23 Mar 2021 15:53:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Kaneda, Erik" <erik.kaneda@intel.com>
Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Message-ID: <20210323155336.GA1639@e121166-lin.cambridge.arm.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
 <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1599238526CF0529394CD9D7F0659@MWHPR11MB1599.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Moore, Robert" <robert.moore@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Mar 22, 2021 at 09:57:58PM +0000, Kaneda, Erik wrote:
> =

> =

> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>
> > Sent: Monday, March 22, 2021 3:36 AM
> > To: Kaneda, Erik <erik.kaneda@intel.com>; linux-arm-
> > kernel@lists.infradead.org; linux-acpi@vger.kernel.org; iommu@lists.lin=
ux-
> > foundation.org; devel@acpica.org; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Moore, Robert <robert.moore@intel.com>
> > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > Sami.Mujawar@arm.com; robin.murphy@arm.com; wanghuiqiang
> > <wanghuiqiang@huawei.com>
> > Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revisi=
on E
> > =

> > [+]
> > =

> > Hi Erik,
> > =

> > As this is now just merged ino acpica-master and based on the discussio=
n we
> > had here,
> > =

> > https://github.com/acpica/acpica/pull/638
> > =

> > I had a discussion with ARM folks(Lorenzo) in the linaro-open-discussio=
ns call
> > and
> > can confirm that the IORT Revision E is not the final specification and=
 has
> > some issues
> > which is now corrected in the latest E.b revision[1]. Also there are no=
 current
> > users
> > for the Rev E and it may not be a good idea to push this version into t=
he Linux
> > kernel
> > or elsewhere.
> > =

> > So could you please revert the merge and I am planning to work on the E=
.b
> > soon.
> Hi,
> =

> > Please let me know if I need to explicitly send a revert pull request o=
r not.
> =

> Please send a revert pull request and I'll remember to not submit Linux-i=
ze the IORT patches.
> =

> From all of the activity that I've seen with the IORT specification,
> it looks like this table is nontrivial to design and maintain. The
> difficulty I have with the table is that I do not understand which
> table revisions are in active use.

Possibly all of them in firmware in the field - I am not sure what you
are asking though; if you can elaborate I'd be grateful.

> So my question is this: which IORT revisions are being actively used?

See above.

Thanks,
Lorenzo

> =

> Thanks,
> Erik
> > =

> > Thanks,
> > Shameer
> > =

> > 1. https://developer.arm.com/documentation/den0049/latest/
> > =

> > > -----Original Message-----
> > > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On
> > Behalf Of
> > > Shameer Kolothum
> > > Sent: 19 November 2020 12:12
> > > To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > iommu@lists.linux-foundation.org; devel@acpica.org
> > > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com;
> > Guohanjun
> > > (Hanjun Guo) <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> > > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> > >
> > > IORT revision E contains a few additions like,
> > > =A0 =A0 -Added an identifier field in the node descriptors to aid tab=
le
> > > =A0 =A0 =A0cross-referencing.
> > > =A0 =A0 -Introduced the Reserved Memory Range(RMR) node. This is used
> > >  =A0 =A0 to describe memory ranges that are used by endpoints and req=
uires
> > >  =A0 =A0 a unity mapping in SMMU.
> > >     -Introduced a flag in the RC node to express support for PRI.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> > >  1 file changed, 19 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > ec66779cb193..274fce7b5c01 100644
> > > --- a/include/acpi/actbl2.h
> > > +++ b/include/acpi/actbl2.h
> > > @@ -68,7 +68,7 @@
> > >   * IORT - IO Remapping Table
> > >   *
> > >   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> > > - * Document number: ARM DEN 0049D, March 2018
> > > + * Document number: ARM DEN 0049E, June 2020
> > >   *
> > >
> > >
> > **********************************************************
> > ******
> > > **************/
> > >
> > > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> > >  	u8 type;
> > >  	u16 length;
> > >  	u8 revision;
> > > -	u32 reserved;
> > > +	u16 reserved;
> > > +	u16 identifier;
> > >  	u32 mapping_count;
> > >  	u32 mapping_offset;
> > >  	char node_data[1];
> > > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> > >  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
> > >  	ACPI_IORT_NODE_SMMU =3D 0x03,
> > >  	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
> > > -	ACPI_IORT_NODE_PMCG =3D 0x05
> > > +	ACPI_IORT_NODE_PMCG =3D 0x05,
> > > +	ACPI_IORT_NODE_RMR =3D 0x06,
> > >  };
> > >
> > >  struct acpi_iort_id_mapping {
> > > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> > >  	u8 reserved[3];		/* Reserved, must be zero */
> > >  };
> > >
> > > -/* Values for ats_attribute field above */
> > > +/* Masks for ats_attribute field above */
> > >
> > > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root
> > > complex supports ATS */
> > > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root
> > > complex doesn't support ATS */
> > > +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex
> > > supports ATS */
> > > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex
> > > supports PRI */
> > >
> > >  struct acpi_iort_smmu {
> > >  	u64 base_address;	/* SMMU base address */
> > > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> > >  	u64 page1_base_address;
> > >  };
> > >
> > > +struct acpi_iort_rmr {
> > > +	u32 rmr_count;
> > > +	u32 rmr_offset;
> > > +};
> > > +
> > > +struct acpi_iort_rmr_desc {
> > > +	u64 base_address;
> > > +	u64 length;
> > > +	u32 reserved;
> > > +};
> > > +
> > >
> > >
> > /**********************************************************
> > *****
> > > ****************
> > >   *
> > >   * IVRS - I/O Virtualization Reporting Structure
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > _______________________________________________
> > Devel mailing list -- devel@acpica.org
> > To unsubscribe send an email to devel-leave@acpica.org
> > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
