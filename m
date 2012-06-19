From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v2 0/7] IOMMU: Groups support
Date: Tue, 19 Jun 2012 11:49:18 +0200
Message-ID: <20120619094918.GH2624@amd.com>
References: <20120530201424.31527.33142.stgit@bling.home>
 <20120606110514.GG757@amd.com>
 <1339429021.24037.8.camel@bling.home>
 <1340040703.17272.2.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340040703.17272.2.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, bhelgaas@google.com, david@gibson.dropbear.id.au, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, ddutile@redhat.com, liuj97@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Jun 18, 2012 at 11:31:43AM -0600, Alex Williamson wrote:
> Anyone?  Alexey & BenH, I know you're familiar with IOMMU groups, please
> give Joerg some kind of indication that you approve of this for POWER.
> David Woodhouse, these patches touch intel-iommu, please ack or comment:
> 
> https://lkml.org/lkml/2012/5/30/445
> https://lkml.org/lkml/2012/5/30/450
> 
> Joerg, maybe we can just add CC: to the commit log?  Thanks,

Well, we can't hold up things forever. Given that the POWER guys had
long discussions with you about previous versions but not about this one
counts as a silent Ack for me ;)

So I already applied the patches into my local tree yesterday and gave
them some additional testing. All looks good so far. I think I will push
the result soon to get this into linux-next.

I'll probably rebase to add the Cc's to the commits before pushing it
out.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
