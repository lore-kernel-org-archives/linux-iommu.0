From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMMU 2-stage support
Date: Wed, 18 Feb 2015 18:56:00 +0000
Message-ID: <20150218185600.GN22017@arm.com>
References: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 18, 2015 at 05:04:21PM +0000, Baptiste Reynal wrote:
> We are currently working on the ARM SMMU 2-stage support in order to
> expose SMMU capabilities to a guest OS.
> By doing some research, we noticed some work has already be done by Will
> Deacon on exposing virtual IOMMU interface to KVM guest. After going
> through slides and code (on
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git<http://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git>,
> branch: iommu/vsmmu), we have some questions :
> 
> - What is the status of this work ? Is Alex still working on it ?

I got a reasonable way through implementing something, but ran into a
wall for a few reasons:

  (1) I don't have anything where I can test this (yet)

  (2) Nobody's actually asking for it...

> - Are there any test case about the current vsmmu implementation ?

No.

> - What is exposed to the guest in the current implementation ?

An emulation of a stage-1 only SMMU.

> - How do the guest program the stage-1 translation ?

Just like it would for a physical SMMU.
It's probably easiest if you look at the (incomplete, WIP) code:

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/vsmmu&id=539dbcb964e5c730791a6a31a4f58ceff4b945c2

Anyway, until somebody actually wants this feature I've put it on ice as
it adds a whole bunch of complication to the ARM SMMU driver, as well as
new user ABI extensions that I don't really want to maintain for fun.

The only murmurs I've heard about IOMMU usage from a guest relate to a
paravirtualised interface, which abstracts the details of the host IOMMU
altogether and allows the translation to be collapsed (which can be
better for TLB utilisation).

Will
