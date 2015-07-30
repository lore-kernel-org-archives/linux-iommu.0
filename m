From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Allow non-ATS devices in IOMMUv2 domains
Date: Thu, 30 Jul 2015 13:24:25 +0200
Message-ID: <20150730112425.GR27614@suse.de>
References: <1438250724-4443-1-git-send-email-joro@8bytes.org>
	<CAFCwf12=3VrHX2M4n8TeV=gkD+-V=_2x4muiozdb39S0A6BmRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFCwf12=3VrHX2M4n8TeV=gkD+-V=_2x4muiozdb39S0A6BmRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Oded,

On Thu, Jul 30, 2015 at 01:08:46PM +0300, Oded Gabbay wrote:
> Why amdkfd's devices are considered a non-IOMMUv2 capable devices ?
> After all, they contain the IOMMUv2 H/W and use it constantly for HSA.

With 4.2 the AMD IOMMU driver relies on iommu groups from the iommu core
code. With that, all functions of a multi-function device will be in one
group (and have to be in one domain). This means that the audio device
which comes with every HSA GPU is in the same group, and this device
lacks the IOMMUv2 features.


	Joerg
