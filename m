From: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
Date: Sat, 7 Feb 2015 23:41:24 +0100 (CET)
Message-ID: <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Reply-To: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joreg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> hat am 6. Februar 2015 um 01:31
geschrieben:
>
> The requirement for this is based on a previous patch to add clock
> support to the ARM SMMU driver[2]. Once we have clock support, it's
> possible that the driver itself may need to be defered which breaks
> a bunch of assumptions about how SMMU probing is supposed to work.
 
Hi Laura,
 
I was hoping that we would not need this, and instead treat the iommu in
the same way as timers and SMP initialization, both
of which need to be run early at boot time but may rely on clock controllers
to be initialized first.
 
Is there a specific requirement that makes this impossible here, or is your
intention to solve the problem more nicely by allowing deferred probing
over forcing the input clocks of the iommu to be early?
 
      Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
