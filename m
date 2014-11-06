From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/amd: Use delayed mmu release notifier
Date: Thu, 6 Nov 2014 23:51:50 +0100
Message-ID: <20141106225150.GT10744@8bytes.org>
References: <54418D7F.3050304@amd.com> <20141106133354.GP10744@8bytes.org>
	<545B7C43.4020106@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <545B7C43.4020106-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 06, 2014 at 03:48:51PM +0200, Oded Gabbay wrote:
> What do you mean ? I don't see I change anything in the API. All the
> changes are internal to amd_iommu_unbind_pasid(). I don't think
> *anyone* calling to amd_iommu_unbind_pasid() will care or will
> notice the slight change in timing of releasing the pasid_state
> object (instead of immediate release, it is released after the
> iteration on the mmu_notifier list has finished)

The API change is that this patch modifies amd_iommu_unbind_pasid() so
that it could be called from an mmu_notifier_release call-back (which is
not possible right now). It does that by adding just another layer of
call-backs and complicates the code. I'd like to keep that outside of
the IOMMUv2 driver.


	Joerg
