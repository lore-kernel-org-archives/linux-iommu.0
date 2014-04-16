From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM SMMU fixes
Date: Wed, 16 Apr 2014 15:22:06 +0100
Message-ID: <20140416142206.GB2005@arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<53440057.6020703@arm.com> <20140414165858.GI12916@arm.com>
	<15544035.e9eK8n7TO4@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15544035.e9eK8n7TO4@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 15, 2014 at 04:55:07PM +0100, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> On a different but related topic, I've written an ipmmu-vmsa.c driver for a 
> Renesas IOMMU. The IP core has custom registers but uses VMSA-compatible page 
> tables. What would you think about sharing the page table management code 
> between the two drivers ? The biggest difference between the two 
> implementations is that I've hardcoded the long descriptor format, while you 
> have reused more system MMU macros that make the arm-smmu driver use 2 or 3 
> levels of page tables depending on whether LPAE is disabled or enabled.

Actually, my driver also only supports the long-descriptor format, so the
code should be shareable. Things I support that you might have issues with
are:

 - Stage-1 and Stage-2 formats (although long-descriptor only)
 - 4k and 64k pages (the latter for arm64 only)
 - Contiguous pte hints

Do you have support for section mappings in your driver? That is something
I'd be keen to add for the ARM SMMU, but it really complicates the code.

Will
