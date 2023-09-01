Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6033FD4;
	Fri,  1 Sep 2023 05:50:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EFC468BEB; Fri,  1 Sep 2023 07:50:21 +0200 (CEST)
Date: Fri, 1 Sep 2023 07:50:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	Michael Roth <michael.roth@amd.com>,
	"Kalra, Ashish" <Ashish.Kalra@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH] iommu/amd: remove amd_iommu_snp_enable
Message-ID: <20230901055020.GA31908@lst.de>
References: <20230831123107.280998-1-hch@lst.de> <d33f6abe-5de1-fdba-6a69-51bcbf568c81@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33f6abe-5de1-fdba-6a69-51bcbf568c81@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 31, 2023 at 01:03:53PM -0500, Kim Phillips wrote:
> +Mike Roth, Ashish
>
> On 8/31/23 7:31 AM, Christoph Hellwig wrote:
>> amd_iommu_snp_enable is unused and has been since it was added in commit
>> fb2accadaa94 ("iommu/amd: Introduce function to check and enable SNP").
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>
> It is used by the forthcoming host SNP support:
>
> https://lore.kernel.org/lkml/20230612042559.375660-8-michael.roth@amd.com/

Then resend it with that support, but don't waste resources and everyones
time now.
