From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/4] iommu: arm smmu: driver updates for 3.12
Date: Mon, 12 Aug 2013 12:45:20 +0100
Message-ID: <20130812114520.GB25995@mudshark.cambridge.arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wed, Jul 31, 2013 at 07:21:24PM +0100, Will Deacon wrote:
> Here's a set of small drivers updates to the ARM SMMU driver that went
> in during the merge window. The main changes are:
> 
>  - Removal of a broken big-endian special case when setting the pgd
>  - Better error reporting when running with a single, combined IRQ line
>  - Removing the dynamic use of VMIDs for stage-1 mappings. This is basically
>    to make life easier for hypervisors, who apparently have a hard life
>    if guest OSs allocate their own VMIDs
>  - Simplification of the VMID/ASID allocation scheme based on the fact
>    that we're just trying to assign one ID per context-bank.
> 
> I've tested these patches with an AArch32 MMU-500 model and not seen any
> problems running stage-1 DMA transactions through the SMMU.

Could you queue these for 3.12 please?

Thanks,

Will
