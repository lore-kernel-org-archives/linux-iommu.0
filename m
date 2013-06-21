From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] documentation: iommu: add description of ARM System
	MMU binding
Date: Fri, 21 Jun 2013 15:55:08 +0200
Message-ID: <20130621135507.GI11309@8bytes.org>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-8-git-send-email-will.deacon@arm.com>
	<20130620200845.GF11309@8bytes.org>
	<20130621095729.GA7766@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130621095729.GA7766-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Jun 21, 2013 at 10:57:29AM +0100, Will Deacon wrote:
> This is a common driver that will support any IOMMUs compatible with v1 or
> v2 of the ARM SMMU architecture. Currently, that includes SMMUs known
> informatively as MMU-400, MMU-401 and MMU-500. I had a look at the other
> IOMMU drivers in the kernel and they seem to be driving incompatible IOMMUs,
> so I don't see how this driver can replace those.
> 
> However, we'll hopefully see ARM SMMU-compatible devices turning up soon (I
> know of many SoCs in development that are looking at them).

That sounds great. So in the future there will be a single driver for
most future SOCs. This is a real improvement over the current situation.

>From NVidia is another driver with 'smmu' in its name, is that one also
incompatible?

> Chaining is really horrible and exists as a hack to support virtualisation
> using two separate SMMUs, where neither of them can support nested
> translation.

I see, thanks for the explanation.


	Joerg
