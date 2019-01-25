From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
Date: Fri, 25 Jan 2019 13:58:24 +0200
Message-ID: <CAHp75VdhqGSCxZSPAW2DXq-cFUcDCoOnpW5mqD27LygGoiLMHA@mail.gmail.com>
References: <20190123230131.42094-1-sfruhwald@google.com>
	<c4e7855966a94b0c999a5f4325a27e90@ausx13mpc120.AMER.DELL.COM>
	<CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A@mail.gmail.com>
	<CAHp75Vc4r=ceP=SOQk2LR2B8fZjmdo33fV3yio3a352WwkMyMA@mail.gmail.com>
	<CAKkQkjD6WGE2jPSqUQ-BpJmevix2vd4GoSFKK5J312mEJB0Jpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKkQkjD6WGE2jPSqUQ-BpJmevix2vd4GoSFKK5J312mEJB0Jpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 25, 2019 at 3:50 AM Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:

First of all, please do not top post!

> I took a quick look at arch_setup_pdev_archdata(), overridden it in
> dcdbas.c and it works well (despite it's being called twice, since
> it's called from platform_device_alloc and platform_device_register).
>
> However, as I am not super familiar with ELF weak method references,
> especially with its scope resolution / versioning part, so as I see
> this weak method was introduced mainly for arch/** specific hooks.
> Is it safe to override this method from driver code, when let's say
> there's another implementation in the x86 arch code (currently there
> isn't)?

No, it should be done somewhere in arch/x86.

OTOH, Intel iommu driver can do it based on the check dev_is_pci().
For now I think it's better to solve this inside Intel iommu driver.

> So while I agree that archdata should be ideally written from within
> this hook to make sure the value is there when the bus notifiers call
> the iommu code (currently not registered for platform_bus), I am just
> a bit worried that this might mask a future generic arch
> implementation and could cause issues. What do you think?

-- 
With Best Regards,
Andy Shevchenko
