From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 11/13] iommu/amd: Don't copy GCR3 table root pointer
Date: Fri, 28 Jul 2017 17:07:01 +0800
Message-ID: <20170728090701.GN24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-12-git-send-email-bhe@redhat.com>
	<20170727155755.GP3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170727155755.GP3610-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/27/17 at 05:57pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:09PM +0800, Baoquan He wrote:
> > When iommu is pre_enabled in kdump kernel, if a device is set up with
> > guest translations (DTE.GV=1), then don't copy GCR3 table root pointer
> > but move the device over to an empty guest-cr3 table and handle the
> > faults in the PPR log (which answer them with INVALID). After all these
> > PPR faults are recoverable for the device and we should not allow the
> > device to change old-kernels data when we don't have to.
> 
> Okay, forget my previous comment about disabling IOMMUv2 features while
> copying. Its done in this patch.

Yeah, as you said. Thanks.

> 
