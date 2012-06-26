From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: atomic context for iommu_map call
Date: Tue, 26 Jun 2012 10:58:53 +0200
Message-ID: <20120626085853.GX2624@amd.com>
References: <20120622112812.GV8140@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120622112812.GV8140-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Alexandra N. Kossovsky" <Alexandra.Kossovsky-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robert Stonehouse <rstonehouse-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 22, 2012 at 03:28:14PM +0400, Alexandra N. Kossovsky wrote:
> Hello.
> 
> It is not clear from the documentation if iommu_map()/iommu_unmap()
> functions may be called from atomic context.
> In case of Intel IOMMU, it works; in case of AMD IOMMU, it does not.
> 
> Was it done by purpose?  May I propose a patch for AMD IOMMU replacing
> GFP_KERNEL by GFP_ATOMIC to make things better?

Well, a better option would be to have an iommu_map_atomic() alongside
the current iommu_map API call.

> We use IOMMU API in OpenOnload project http://www.openonload.org/,
> and we get better latency with Intel IOMMU because we are not
> forced to use threaded IRQ.

Yes, the IRQ for the AMD IOMMU is threaded. But I don't understand how
that is relevant for your latency. Can you give more details here?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
