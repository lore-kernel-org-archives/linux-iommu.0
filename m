From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Tue, 04 Feb 2014 17:33:35 +0000
Message-ID: <20140204173335.8C7CBC40B12@trevor.secretlab.ca>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>	<
	20140117110830.GW3471@alberich>	<52E92842.3000001@amd.com> <
	CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
	< 52E93360.1000904@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52E93360.1000904-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 29 Jan 2014 10:59:12 -0600, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
> On 1/29/2014 10:57 AM, Rob Herring wrote:
> >>> diff --git a/include/linux/of.h b/include/linux/of.h
> >>> >>index 276c546..24e1b28 100644
> >>> >>--- a/include/linux/of.h
> >>> >>+++ b/include/linux/of.h
> >>> >>@@ -67,7 +67,7 @@ struct device_node {
> >>> >>   #endif
> >>> >>   };
> >>> >>
> >>> >>-#define MAX_PHANDLE_ARGS 8
> >>> >>+#define MAX_PHANDLE_ARGS 16
> >> >
> >> >
> >> >Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
> >> >this be changed to be able to support 128 StreamIDs as well?  Although I am
> >> >not sure if this would be too big to have on the stack per Rob's comment in
> >> >the previous patch set.
> > Do you actually need 128 now? If not, then we can deal with that when
> > we get there. There are lots of things in spec's that are not actually
> > implemented or supported.
> 
> Actually, we are using 32 on the AMD system. So, do you think we can set 
> this to 32 instead?

The helper really wasn't designed for large number of arguments to a
phandle. If the phandle args are really that large, then it may be
better to have a parser that allocates the space needed and/or puts the
data directly into the destination data structure.

g.
