From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Wed, 2 Mar 2016 13:35:01 +0000
Message-ID: <20160302133457.GD7637@arm.com>
References: <1456348433-3337-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160302030756.GC7637@arm.com>
	<C2D36A36-8247-4432-BE50-14129D9D8E5B@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C2D36A36-8247-4432-BE50-14129D9D8E5B-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Akula,
	Geethasowjanya" <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 02, 2016 at 03:23:57AM +0000, Chalamarla, Tirumalesh wrote:
> On 3/1/16, 7:07 PM, "Will Deacon" <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >On Wed, Feb 24, 2016 at 01:13:53PM -0800, Tirumalesh Chalamarla wrote:
> >> +		smmu->cavium_smmu_id = cavium_smmu_count;
> >> +		cavium_smmu_count++;
> >> +		smmu->cavium_id_base =
> >> +			(smmu->cavium_smmu_id * ARM_SMMU_MAX_CBS);
> >
> >Can you not use num_context_banks here, instead of the constant?
> We need total context banks so far, so ARM_SMMU_MAX_CBS is best option.
> For Thunder both are same anyway. 

Hmm, so couldn't you instead just update a running total as you go along?
That is, initialise it to zero, then atomic_add_return(num_context_banks)
when you probe?

Will
