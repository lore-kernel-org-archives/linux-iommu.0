From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] iommu/amd - Set the device table entry PPR bit for
	IOMMU V2 devices
Date: Wed, 20 Dec 2017 12:02:51 -0700
Message-ID: <20171220120251.435ed475@t450s.home>
References: <151372174181.127118.3644062052273990281.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <151372174181.127118.3644062052273990281.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 19 Dec 2017 16:15:41 -0600
Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:

> The AMD IOMMU specification Rev 3.00 (December 2016) introduces a
> new Enhanced PPR Handling Support (EPHSup) bit in the MMIO register
> offset 0030h (IOMMU Extended Feature Register).
> 
> When EPHSup=1, the IOMMU hardware requires the PPR bit of the
> device table entry (DTE) to be set in order to support PPR for a
> particular endpoint device.
> 
> Please see https://support.amd.com/TechDocs/48882_IOMMU.pdf for
> this revision of the AMD IOMMU specification.
> 
> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> ---
>  0 files changed

Hmm, something funky there, but looks fine otherwise.  Applied to
v4.16-iommu/amd.  Thanks,

Alex
