From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] VT-d fixes and ACPI device mapping support for 3.15
Date: Mon, 24 Mar 2014 16:44:53 +0100
Message-ID: <20140324154449.GA2775@8bytes.org>
References: <1395674279.4880.236.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395674279.4880.236.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 24, 2014 at 03:17:59PM +0000, David Woodhouse wrote:
> J=F6rg, please pull into your x86/vt-d branch from
> =

> 	git://git.infradead.org/iommu-2.6
> =

> This contains the two patch sets I've posted in the last week; first the
> set which fixes the use-after-free issues with IOTLB flushes, adds some
> missing IOTLB flushes and generally improves unmap performance. And then
> the support for DMA mapping of ACPI devices.
> =

> This contains a couple of fixes triggered by Fengguang's build-test
> robots; one of which was posted as [PATCH 34/33] a few hours ago, and
> the other of which just moves the 'segment' member of struct intel_iommu
> outside the #ifdef CONFIG_INTEL_IOMMU since it's accessed from dmar.c
> without that config option set. I've merged both of those fixes back
> into the original offending patch, rather than putting them on top.
> =

>  drivers/iommu/dmar.c        | 166 ++++++++---
>  drivers/iommu/intel-iommu.c | 979 ++++++++++++++++++++++++++++++++++++++=
++-------------------------
>  include/acpi/actbl2.h       |  15 +-
>  include/linux/dmar.h        |  18 +-
>  include/linux/intel-iommu.h |   1 +
>  5 files changed, 759 insertions(+), 420 deletions(-)

Pulled, thanks David.
