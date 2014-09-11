From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Support for nesting IOMMUs in VFIO
Date: Thu, 11 Sep 2014 18:10:52 +0100
Message-ID: <20140911171052.GB6158@arm.com>
References: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409651619-27342-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Tue, Sep 02, 2014 at 10:53:36AM +0100, Will Deacon wrote:
> Hello,
> 
> This is version three of the patches I originally posted here:
> 
>   RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
>   RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700
> 
> Changes since RFCv2 include:
> 
>   - Dropped the RFC tag
>   - Rebased onto 3.17-rc*
>   - Iterate the support bus_types (currently just PCI) and check that
>     nesting is actually supported
> 
> The corresponding arm-smmu changes are included to show how the new
> domain attribute can be used.
> 
> All feedback welcome,

Do you have any comments on this series? I've got a fair amount of work
building on top of it, so it would good to either fix it or see about
getting it merged.

Cheers,

Will
