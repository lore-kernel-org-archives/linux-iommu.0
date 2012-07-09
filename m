From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: atomic context for iommu_map call
Date: Mon, 9 Jul 2012 11:42:10 +0200
Message-ID: <20120709094210.GH2639@amd.com>
References: <20120622112812.GV8140@oktetlabs.ru>
	<20120626085853.GX2624@amd.com>
	<20120626180743.GV15796@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120626180743.GV15796-JyIX8gxvWYPr2PDY2+4mTGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Cc: "Alexandra N. Kossovsky" <Alexandra.Kossovsky-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robert Stonehouse <rstonehouse-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 26, 2012 at 11:07:43AM -0700, Chris Wright wrote:
> * Joerg Roedel (joerg.roedel-5C7GfCeVMHo@public.gmane.org) wrote:
> > On Fri, Jun 22, 2012 at 03:28:14PM +0400, Alexandra N. Kossovsky wrote:
> > > Hello.
> > > 
> > > It is not clear from the documentation if iommu_map()/iommu_unmap()
> > > functions may be called from atomic context.
> > > In case of Intel IOMMU, it works; in case of AMD IOMMU, it does not.
> > > 
> > > Was it done by purpose?  May I propose a patch for AMD IOMMU replacing
> > > GFP_KERNEL by GFP_ATOMIC to make things better?
> > 
> > Well, a better option would be to have an iommu_map_atomic() alongside
> > the current iommu_map API call.
> 
> A simple change for ->map to include flags and an iommu_map_atomic helper
> that calls ->map w/ GFP_ATOMIC will hit this in AMD IOMMU:
> 
>         mutex_lock(&domain->api_lock);
> -       ret = iommu_map_page(domain, iova, paddr, prot, page_size);
> +       ret = iommu_map_page(domain, iova, paddr, prot, page_size, flags);
>         mutex_unlock(&domain->api_lock);

Yes, something like this was in my mind too. Can you send this as a real
patch-set for inclusion or is it better if someone else is picking this
up?


	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
