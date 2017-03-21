From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Implement SMMU passthrough using the default domain
Date: Tue, 21 Mar 2017 17:46:40 +0100
Message-ID: <20170321164640.GI29659@8bytes.org>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
	<20170321154624.GC29659@8bytes.org>
	<20170321164241.GD30948@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170321164241.GD30948-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 21, 2017 at 04:42:41PM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> On Tue, Mar 21, 2017 at 04:46:24PM +0100, Joerg Roedel wrote:
> > On Fri, Mar 10, 2017 at 08:49:31PM +0000, Will Deacon wrote:
> > > Will Deacon (5):
> > >   iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
> > >   iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
> > >   iommu/arm-smmu-v3: Make arm_smmu_install_ste_for_dev return void
> > >   iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY
> > >     domains
> > >   iommu: Allow default domain type to be set on the kernel command line
> > > 
> > >  Documentation/admin-guide/kernel-parameters.txt |  6 ++
> > >  drivers/iommu/arm-smmu-v3.c                     | 76 +++++++++++++++----------
> > >  drivers/iommu/arm-smmu.c                        | 26 ++++++++-
> > >  drivers/iommu/iommu.c                           | 17 +++++-
> > >  4 files changed, 90 insertions(+), 35 deletions(-)
> > 
> > Besides my one comment on the last patch this series looks good to me.
> > Do you plan to include it (with the fall-back) into your pull-request?
> 
> Yes, that would certainly be easiest for me, given the changes to the
> SMMU drivers. However, if you prefer it separately then I can do that too.

No, just send it with you usual bulk of other smmu patches.


Thanks,

	Joerg
