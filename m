From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Thu, 27 Apr 2017 23:03:25 +0200
Message-ID: <20170427210325.GE1332@8bytes.org>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170427201018.70c8be5a@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Gerald,

thanks for your reply. I have some more questions, please see below.

On Thu, Apr 27, 2017 at 08:10:18PM +0200, Gerald Schaefer wrote:

> Well, there is a separate zpci_dev for each pci_dev on s390,
> and each of those has its own separate dma-table (thus not shared).

Is that true for all functions of a PCIe card, so does every function of
a device has its own zpci_dev structure and thus its own DMA-table?

My assumption came from the fact that the zpci_dev is read from
pci_dev->sysdata, which is propagated there from the pci_bridge
through the pci_root_bus structures.

> Given this "separate zpci_dev for each pci_dev" situation, I don't
> see what this update actually changes, compared to the previous code,
> see also my comments to that patch.

The add_device call-back is invoked for every function of a pci-device,
because each function gets its own pci_dev structure. Also we usually
group all functions of a PCI-device together into one iommu-group,
because we don't trust that the device isolates its functions from each
other.

Regards,

	Joerg
