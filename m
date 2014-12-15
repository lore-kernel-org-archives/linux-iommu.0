From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Bug 89751] New: Allocating domain for fallback device failed
Date: Mon, 15 Dec 2014 11:25:33 -0700
Message-ID: <CAErSpo4_SvU+SX09NKdi1jc3gQT-3vbAaiGPMShURm-hRny=_w@mail.gmail.com>
References: <bug-89751-41252@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bug-89751-41252-3bo0kxnWaOQUvHkbgXJLS5sdmw4N0Rt+2LY78lusg7I@public.gmane.org/>
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
Cc: "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, rwarsow-Mmb7MZpHnFY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+to David, +cc iommu list, Joerg]

On Sun, Dec 14, 2014 at 7:44 AM,  <bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=89751
>
>             Bug ID: 89751
>            Summary: Allocating domain for fallback device failed
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.18
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>           Reporter: rwarsow-Mmb7MZpHnFY@public.gmane.org
>         Regression: No
>
> Created attachment 160531
>   --> https://bugzilla.kernel.org/attachment.cgi?id=160531&action=edit
> dmesg
>
> Since enabling INTEL_IOMMU_DEFAULT_ON I see "Allocating domain for fallback
> device failed" in my logs.

Ronald, do you know whether this is a regression?
