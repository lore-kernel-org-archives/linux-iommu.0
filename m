Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3A125AB;
	Tue,  6 Jun 2023 09:24:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64DA367373; Tue,  6 Jun 2023 11:24:35 +0200 (CEST)
Date: Tue, 6 Jun 2023 11:24:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230606092435.GA31061@lst.de>
References: <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com> <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk> <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com> <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk> <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com> <14f2b1ab-2c7c-fa4d-5854-3df08ac9feef@yahoo.co.uk> <1928df45-7b56-a8a4-21b5-22e5d8ef95eb@leemhuis.info> <9b602abc-37e9-f236-37ee-71bcf1b7ce66@arm.com> <211f3938-2f93-cad7-a92b-821d3ac45b9e@leemhuis.info> <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 02, 2023 at 03:07:19PM +0200, Thorsten Leemhuis wrote:
> Christoph, could you do me a favor and...

> ...submit that quirk, as Bjorn and Alex apparently didn't pick this up?
> I could do so myself, but prefer to leave that to people that actually
> known what they are doing -- and thus can also handle problems later, in
> case any show up. And strictly speaking it apparently was you who caused
> this regression with 78013eaadf6 ("x86: remove the IOMMU table
> infrastructure").

Well, Robin posted it so I think he should also finish it up and get
the credit.  Robin, can you send the quirk with a formal signoff?

