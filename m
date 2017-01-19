From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/10] iommu/of: Prepare for deferred IOMMU configuration
Date: Thu, 19 Jan 2017 14:40:56 +0000
Message-ID: <20170119144056.GA4312@red-moon>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
	<1480465344-11862-3-git-send-email-sricharan@codeaurora.org>
	<20161130161723.GA9042@red-moon>
	<c89825aa-c75f-8493-fe92-7cc97f525bc7@arm.com>
	<20161201112917.GA9680@red-moon>
	<003601d2672e$91744b40$b45ce1c0$@codeaurora.org>
	<20170105122714.GA30449@red-moon>
	<7cd7bcfb-abae-2948-c3f8-230c0d9c9db6@arm.com>
	<005f01d26763$450f9cc0$cf2ed640$@codeaurora.org>
	<20170106162400.GA8109@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170106162400.GA8109@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,

On Fri, Jan 06, 2017 at 04:24:00PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 05, 2017 at 08:21:53PM +0530, Sricharan wrote:
> > Hi,
> > 
> > [...]
> > 
> > >>>
> > >>> With the thinking of taking this series through, would it be fine if i
> > >>> cleanup the pci configure hanging outside and push it in to
> > >>> of/acpi_iommu configure respectively ? This time with all neeeded for
> > >>> ACPI added as well.  Also on the last post of V4, Lorenzo commented
> > >>> that it worked for him, although still the of_match_node equivalent in
> > >>> ACPI has to be added. If i can get that, then i will add that as well
> > >>> to make this complete.
> > >>
> > >> Question: I had a look into this and instead of fiddling about with the
> > >> linker script entries in ACPI (ie IORT_ACPI_DECLARE - which I hope this
> > >> patchset would help remove entirely), I think that the only check we
> > >> need in IORT is, depending on what type of SMMU a given device is
> > >> connected to, to check if the respective SMMU driver is compiled in the
> > >> kernel and it will be probed, _eventually_.
> > >>
> > >> As Robin said, by the time a device is probed the respective SMMU
> > >> devices are already created and registered with IORT kernel code or
> > >> they will never be, so to understand if we should defer probing
> > >> SMMU device creation is _not_ really a problem in ACPI.
> > >>
> > >> To check if a SMMU driver is enabled, do we really need a linker
> > >> table ?
> > >>
> > >> Would not a check based on eg:
> > >>
> > >> /**
> > >>  * @type: IOMMU IORT node type of the IOMMU a device is connected to
> > >>  */
> > >> static bool iort_iommu_driver_enabled(u8 type)
> > >> {
> > >> 	switch (type) {
> > >> 	case ACPI_IORT_SMMU_V3:
> > >> 		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
> > >
> > >IS_BUILTIN(...)
> > >
> > >> 	case ACPI_IORT_SMMU:
> > >> 		return IS_ENABLED(CONFIG_ARM_SMMU);
> > >> 	default:
> > >> 		pr_warn("Unknown IORT SMMU type\n");
> > >
> > >Might displaying the actual value be helfpul for debugging a broken IORT
> > >table?
> > >
> > >> 		return false;
> > >> 	}
> > >> }
> > >>
> > >> be sufficient (it is a bit gross, agreed, but it is to understand if
> > >> that's all we need) ? Is there anything I am missing ?
> > >>
> > >> Let me know, I will put together a patch for you I really do not
> > >> want to block your series for this trivial niggle.
> > >
> > >Other than that, though, I like it :) IORT has a small, strictly
> > >bounded, set of supported devices, so I really don't see the need to go
> > >overboard putting it on parity with DT when something this neat and
> > >simple will suffice.
> > >
> > 
> > Ok sure, looks correct for me as well in whole of the context here.
> 
> Ok, I put together a branch where you can find your original series
> plus some ACPI patches for you to test and use:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git iommu/probe-deferral
> 
> Feel free to post the additional patches I added along with your series
> (that from what I gather you have reworked already) and please both have a
> look if the deferral mechanism I put in place in ACPI makes sense to you.

Did you have time to make progress on this ? I think it is time we
posted the complete series to aim for 4.11 please, if you need help just
let us know.

Thanks !
Lorenzo
