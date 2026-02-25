Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA43921EC;
	Wed, 25 Feb 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014279; cv=none; b=nuiZF/mn3izYy50r6y/qC6Kc8wO20947er06naXW6UZGxO++vwIEwMDP1Zky/RBUIA2GBscvYl3w4woN4+Q3gOvYJrDajZVEIT70TJP4g7PTptWlzY263qtEqXj0x2GEv1RZrq5s9qAMrETtIIXG5QXZASLAotTDYgl5EdK3VTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014279; c=relaxed/simple;
	bh=eSZii8dv7Xz5UWGE+/ISFeZ7qD7AF9CYPLIPb7rv3xU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vFf5eQadsKz2UGjVwiMOl43R69ZXqnBD3Wn7FE1II9Tis7UM8a2CQPCW4R+h/W0gq1GoC1j9n3tNyUw4RBD9nfC1x13VURU4TiKfMpGr06GxvQMi/7iaNxeBSI0HO5LwNhtdT3gJI6L0rhhZy8lZiisx8XVkRx7yWFJL+KPCLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XCmu9iSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YBNPsb1O; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XCmu9iSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YBNPsb1O"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id E45A31301181;
	Wed, 25 Feb 2026 05:11:12 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 25 Feb 2026 05:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772014272;
	 x=1772021472; bh=Ncaaat0snY7jJs/mEFoT42GaKoP2o+ezuKrxHb8TFHY=; b=
	XCmu9iSy7wkh3TiAjblgc++aqpfh8bzBaX5xtwiu5P63hNy0HGOSBhcpngyRaEmn
	MNkeDuD7SJ8ctVIAXmhu02SGHcLnH8+QmeN4PepDqzAsfYs1qF0BswldVdA/X3AL
	JtBOvKWkiBERce7lXxj+rghQCqlCMx3R9xIIpIvcQJKWtHCKs7darlbEye6J7qkV
	dhiSSh56NKiqvOvHjUd0G+5iS2TfAkQjYD45aO2Y3vB7omo1ZRHak5XZ2q8HOakG
	vXR01R47hS4zcA5M6gANX6GDwxMjWwDncn16TLyMRiMyRQjg6ThsJIrmAJgv4PI8
	HO8+vi2gbrUiYaORt71ayQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772014272; x=
	1772021472; bh=Ncaaat0snY7jJs/mEFoT42GaKoP2o+ezuKrxHb8TFHY=; b=Y
	BNPsb1OKogLePj4irrYimnHu5ngaEM8EQE83ueew8eNEQhlXs6S2Uj4nk3+9lmxh
	HHp4+rK+IDYP+IPwUrkaDQWD0qCdoo1q2e2ldc48Q0pZZTLPBUVHXt+CRStIhXqe
	GVR/aScYSW+lnyIfS3Ipf5e8q0ryzWoU1Utv0WJE6Ps+oLVr2InX25qgnvyJxx+0
	0SDXQtX7WWae56GZbgtq/2IneS1aNfG8Elrs7ZpFcHcEbqPWg0U5RGcxki4914e8
	fe1ndx2tkoSq63G2w9EG5urIeoO3cQ544fcyk13uqEcC3U503N8YgAQSsS8BxhX3
	VMFqXVWhm3E1UA6+ANWZQ==
X-ME-Sender: <xms:vcqeaSewtj2rvXaz7ThqOHJu4ZceQ2iicjaxs70AHm2TET73grTGVQ>
    <xme:vcqeaXDejnrl0Bc5Xk_M5u-kvnP24I5_FlH9SDXNaYnswVxAyib3kqVH-cEfmYzzH
    AYRbhhIh-k3Z9yIBLBd1h7DCFbPBclCx4XpKx8Y_EQdUvaF9pyk06Mj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegufihmfiesrg
    hmrgiiohhnrdgtohdruhhkpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhies
    rghmugdrtghomhdprhgtphhtthhopegrihhksegrmhgurdgtohhmpdhrtghpthhtoheprg
    hshhhishhhrdhkrghlrhgrsegrmhgurdgtohhmpdhrtghpthhtohephhhuihgsohdrfigr
    nhhgsegrmhgurdgtohhmpdhrtghpthhtohepjhhovghrghdrrhhovgguvghlsegrmhgurd
    gtohhmpdhrtghpthhtohepkhhimhdrphhhihhllhhiphhssegrmhgurdgtohhmpdhrtghp
    thhtohepmhhitghhrggvlhdrrhhothhhsegrmhgurdgtohhm
X-ME-Proxy: <xmx:vcqeaX6CjSXy0y3XoYaG0ZfAotWgcL_dZk9waDyWbq0Co3_wK5c2Cg>
    <xmx:vcqeaQqJBpTMBTZKw4itiiJlNfvIUzAD0GaBUgV4CbQT031P3jBELw>
    <xmx:vcqeaXVhZ8zRZi8ex_-yahKSruF9mo1F_ZOXk-dVmP_UDL5D6GbbUA>
    <xmx:vcqeaQQEZ2YUrNtfuoYWX0PFHPmUJoxl8nBUNVCUc-smNZzYmuizOA>
    <xmx:wMqeaYwYFEtQBeR5qALe60J2vOFcWhSiDbmzBu_rT8v7T30_D2ckmYNG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A9E0D700069; Wed, 25 Feb 2026 05:11:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: APJbg_pXKWbw
Date: Wed, 25 Feb 2026 11:10:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Williams" <dan.j.williams@intel.com>,
 "Alexey Kardashevskiy" <aik@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Neeraj Upadhyay" <Neeraj.Upadhyay@amd.com>,
 "Ashish Kalra" <ashish.kalra@amd.com>,
 "Stefano Garzarella" <sgarzare@redhat.com>,
 "Melody Wang" <huibo.wang@amd.com>,
 "Seongman Lee" <augustus92@kaist.ac.kr>,
 "Joerg Roedel" <joerg.roedel@amd.com>,
 "Nikunj A Dadhania" <nikunj@amd.com>,
 "Michael Roth" <michael.roth@amd.com>,
 "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "David Woodhouse" <dwmw@amazon.co.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Denis Efremov" <efremov@linux.com>, "Geliang Tang" <geliang@kernel.org>,
 "Piotr Gregor" <piotrgregor@rsyncme.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Alex Williamson" <alex@shazbot.org>,
 "Jesse Barnes" <jbarnes@virtuousgeek.org>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Yinghai Lu" <yinghai@kernel.org>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 "Xu Yilun" <yilun.xu@linux.intel.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Kim Phillips" <kim.phillips@amd.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Claire Chang" <tientzu@chromium.org>, linux-coco@lists.linux.dev,
 iommu@lists.linux.dev
Message-Id: <61d6cd68-cd51-4c6c-92fc-5aa6d01fccaa@app.fastmail.com>
In-Reply-To: <699e93db9ad47_1cc510090@dwillia2-mobl4.notmuch>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-2-aik@amd.com>
 <699e93db9ad47_1cc510090@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH kernel 1/9] pci/tsm: Add TDISP report blob and helpers to parse it
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 25, 2026, at 07:16, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>> +struct tdi_report_header {
>> +	__u16 interface_info; /* TSM_TDI_REPORT_xxx */
>> +	__u16 reserved2;
>> +	__u16 msi_x_message_control;
>> +	__u16 lnr_control;
>> +	__u32 tph_control;
>> +	__u32 mmio_range_count;
>> +} __packed;
>> +
>> +/*
>> + * Each MMIO Range of the TDI is reported with the MMIO reporting offset added.
>> + * Base and size in units of 4K pages
>> + */
>> +#define TSM_TDI_REPORT_MMIO_MSIX_TABLE		BIT(0)
>> +#define TSM_TDI_REPORT_MMIO_PBA			BIT(1)
>> +#define TSM_TDI_REPORT_MMIO_IS_NON_TEE		BIT(2)
>> +#define TSM_TDI_REPORT_MMIO_IS_UPDATABLE	BIT(3)
>> +#define TSM_TDI_REPORT_MMIO_RESERVED		GENMASK(15, 4)
>> +#define TSM_TDI_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
>> +
>> +struct tdi_report_mmio_range {
>> +	__u64 first_page;		/* First 4K page with offset added */
>> +	__u32 num;			/* Number of 4K pages in this range */
>> +	__u32 range_attributes;		/* TSM_TDI_REPORT_MMIO_xxx */
>
> Those should be __le64 and le32, right? But see below for another
> option...

If these come from DMA transfers from a device, yes.

>> +} __packed;

The structure appears to be allocated with kzalloc, so it is always
aligned to __alignof__(u64) or higher, and it's better to drop the
__packed annotation.

>
> /*
>  * PCIe ECN TEE Device Interface Security Protocol (TDISP)
>  *
>  * Device Interface Report data object layout as defined by PCIe r7.0 
> section
>  * 11.3.11
>  */
> #define PCI_TSM_DEVIF_REPORT_INFO 0
> #define PCI_TSM_DEVIF_REPORT_MSIX 4
> #define PCI_TSM_DEVIF_REPORT_LNR 6
> #define PCI_TSM_DEVIF_REPORT_TPH 8
> #define PCI_TSM_DEVIF_REPORT_MMIO_COUNT 12
> #define  PCI_TSM_DEVIF_REPORT_MMIO_PFN 0 /* An interface report 'pfn' 
> is 4K in size */
> #define  PCI_TSM_DEVIF_REPORT_MMIO_NR_PFNS 8
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR 12
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
> #define  PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
> #define  PCI_TSM_DEVIF_REPORT_MMIO_SIZE (16)
> #define PCI_TSM_DEVIF_REPORT_BASE_SIZE(nr_mmio) (16 + nr_mmio * 
> PCI_TSM_DEVIF_REPORT_MMIO_SIZE)
>
> Any strong feelings one way or the other? I have a mild preference for
> this offset+bitfields approach.

I assume by bitfield you mean the macros above, not the C structure
syntax with ':', right? The macros seem fine to me, while C bitfields
again would make the code nonportable due to architecture specific
bitfield positioning.

       Arnd
