From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux Plumbers ACPI/PM, PCI Microconference
Date: Wed, 24 Jul 2013 10:30:33 -0600
Message-ID: <CAKocOOOW6+eqb6GTsWLgonQQ7uy5R10t6L_T3jaTN9qSbetVeQ@mail.gmail.com>
References: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
	<CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Myron Stowe <myron.stowe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 23, 2013 at 10:06 AM, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, Jul 16, 2013 at 8:21 PM, Myron Stowe <myron.stowe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Linux Plumbers has approved an ACPI/PM, PCI microconference. The
>> overview page is here:
>>
>> http://wiki.linuxplumbersconf.org/2013:pci_subsystem
>>
>> We would like to start receiving volunteers for presenting topics of
>> interest.  There is a lot of activity in these subsystems so please
>> respond by submitting presentation or discussion proposals that you
>> would be willing to cover for consideration.  You should also feel
>> free to submit ideas as proposals that others could cover.
>
> Somebody else privately suggested these ARM/PCI topics:
>
>> -> how it's been cleaned up to be more common across arm-32 machines
>> -> dependencies on dtb
>> -> future use/dependency(s) on ACPI
>> -> hotplug support issues (if any; acpi (host-bridge) vs <whatever ARM uses> ?)
>
> and I'm interested in those as well.  There seems to be a lot of
> activity in that area.  In addition, I'm interested in ARM IOMMU
> support.  I see drivers/iommu/arm-smmu.c, but it's brand-new and I
> haven't looked at it at all.
>

I second this topic. I am interested in ARM/iommu space also.

thanks,
-- Shuah
