From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: VFIO on ARM64
Date: Tue, 12 Sep 2017 12:27:56 -0600
Message-ID: <20170912122756.2eb29bb2@t450s.home>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[Cc +Eric Auger]

On Tue, 12 Sep 2017 23:31:00 +0530
valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi, as per VFIO documentation i see that we need to see 
> "/sys/bus/pci/devices/0000:06:0d.0/iommu_group" in order to find group 
> in which PCI bus is attached.
> But as per drivers/pci/pci-sysfs.c in static struct attribute 
> *pci_dev_attrs[], i don't see any such attribute.
> I tried enabling SMMUv2 driver and SMMU for PCIe node on our SOC, but 
> this file doesn't show up and also in /sys/kernel/iommu_group i do not 
> see "/sys/kernel/iommu_groups/17/devices/0000:00:1f.00" file, i see only 
> PCIe root port device tree node in that group and not individual buses.
> So on ARM64 for showing these paths i.e show specific to each bus, does 
> SMMU need any particular confguration (we have SMMUv2) ?
> Do we need any specific kernel configuration ?
> 
> 
> Regards,
> Valmiki
