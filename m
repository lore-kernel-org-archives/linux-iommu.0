From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
Date: Thu, 3 Nov 2016 16:00:06 +0000
Message-ID: <20161103160006.GS22791@arm.com>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103153303.GA837-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, Nov 03, 2016 at 09:33:04AM -0600, Joerg Roedel wrote:
> On Fri, Oct 28, 2016 at 05:01:48PM +0100, Will Deacon wrote:
> >       iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s
> 
> Hmm, this patch is pretty ugly. Wouldn't it be better to have
> hardware-independent init-routine in the arm-smmu-v3 driver that checks
> DT whether there is an SMMU at all and if yes, sets the per-bus
> iommu-ops?

We're basically doing that already, since the bus_set_iommu call happens in
the probe routine, which won't run unless an SMMUv3 has been found in the
DT. The issue we're trying to avoid is failing the probe of a second SMMUv3
in the system, because the bus will already have the iommu ops set by the
first SMMUv3 that probed.

I suppose we could go and compare bus->iommu_ops with &arm_smmu_ops, but
given that we can't support different IOMMU types on a single bus, I don't
think we gain anything from that.

Will
