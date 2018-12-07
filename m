From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
Date: Fri, 7 Dec 2018 09:11:16 -0800
Message-ID: <20181207171116.GA29923@bombadil.infradead.org>
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
 <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: mhocko@suse.com, heiko@sntech.de, peterz@infradead.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net, m.szyprowski@samsung.com, sfr@canb.auug.org.au, oleksandr_andrushchenko@epam.com, joro@8bytes.org, linux@armlinux.org.uk, iommu@lists.linux-foundation.org, airlied@linux.ie, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, treding@nvidia.com, linux-media@vger.kernel.org, keescook@chromium.org, pawel@osciak.com, riel@surriel.com, rppt@linux.vnet.ibm.com, boris.ostrovsky@oracle.com, mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, jgross@suse.com, hjc@rock-chips.com, xen-devel@lists.xen.org, kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de, Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +			struct page **pages, unsigned long page_count)
> > +{
> > +	unsigned long uaddr = addr;
> > +	int ret = 0, i;
> 
> Some of the sites being replaced were effectively ensuring that vma and
> pages were mutually compatible as an initial condition - would it be worth
> adding something here for robustness, e.g.:
> 
> +	if (page_count != vma_pages(vma))
> +		return -ENXIO;

I think we want to allow this to be used to populate part of a VMA.
So perhaps:

	if (page_count > vma_pages(vma))
		return -ENXIO;
