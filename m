From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu: KVM PCIe/MSI passthrough on ARM/ARM64 for 4.11
Date: Mon, 30 Jan 2017 15:59:47 +0100
Message-ID: <20170130145946.GA28129@8bytes.org>
References: <20170127165021.GC10758@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170127165021.GC10758-5wv7dgnIgG8@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 27, 2017 at 04:50:22PM +0000, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull Eric's guest-MSI series for 4.11. This has been through
> considerable review and associated rework (including a session at LPC),
> but it has stabilised at last and we all seem to be happy with it. Eric's
> done a great job of respinning these and remaining patient while we
> pulled him in a bunch of different directions.
> 
> With these patches applied, it's possible for us to pass PCI devices
> through to KVM guests on arm64 using VFIO and have them signal interrupts
> using MSIs targetting the ITS via the SMMU. Acronym soup, sure, but it's
> much better than legacy wired irqs!
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:
> 
>   Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git iommu/guest-msi

Pulled, thanks Will.
