Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048B65B;
	Sun, 24 Sep 2023 07:49:48 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qkJrw-0003js-LP; Sun, 24 Sep 2023 09:49:32 +0200
Message-ID: <16f0e113-9103-408f-bf5f-9f90442c99ed@leemhuis.info>
Date: Sun, 24 Sep 2023 09:49:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs
 that support them
Content-Language: en-US, de-DE
To: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
 "Justin M. Forbes" <jforbes@fedoraproject.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695541789;de4ea16e;
X-HE-SMSGID: 1qkJrw-0003js-LP

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 22.09.23 15:40, Hector Martin wrote:
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and the IOMMU driver might not expect FQ domains at
> ops->attach_dev() time.
> 
> Ensure that we immediately clamp FQ domains to plain DMA if not
> supported by the driver at device attach time, not later.
> 
> This regressed apple-dart in v6.5.
> [...]


Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced a4fdd9762272
#regzbot title iommu: apple-dart regressed
#regzbot monitor:
https://lore.kernel.org/all/20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st/
#regzbot fix: iommu/apple-dart: Handle DMA_FQ domains in attach_dev()
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
