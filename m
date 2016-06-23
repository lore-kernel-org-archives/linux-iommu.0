From: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag
	PCI_DEV_FLAGS_DMA_ALIAS_ROOT
Date: Thu, 23 Jun 2016 09:19:29 -0400 (EDT)
Message-ID: <E235EFDF-81B0-4A93-8F2D-49065B202581@redhat.com>
References: <linux-pci@vger.kernel.org>
	<1462700001-30086-1-git-send-email-jchandra@broadcom.com>
	<5730621B.2050503@arm.com>
	<CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
	<573340F9.6050507@arm.com>
	<037404e2-3168-8f99-0bdb-bb929776108e@redhat.com>
	<576BD031.7090105@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <576BD031.7090105-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Quick reply (sorry about top post): I am just getting online so I might discover that this callback is shared by both - in which case, cool - but if not, we need an interim ACPI solution.

Aside: Current RHEL Server for ARM (RHELSA) explicitly disables SMMUv3 support because (I warned the folks involved more than a year ago), we will only support ACPI/IORT, and as you can imagine, many people would like us to enable support for device passthrough and robustness, not to mention 32-bit devices (32-bit DMA mask). Nonetheless, that will only happen when the upstream kernel has IORT and quirks in place.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 23, 2016, at 08:04, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> On 23/06/16 06:01, Jon Masters wrote:
>>> On 05/11/2016 10:26 AM, Robin Murphy wrote:
>>> (I have no actual objection to this patch, though, and at this point
>>> I'm just chucking ideas about).
>> 
>> Can I ask what the next steps are here? We're looking for upstream
>> direction to guide some internal activities and could really do with
>> understanding how you'd like to solve this one longer term as well as
>> what interim solution could be acceptable until we get there.
> 
> Well, for now I'm planning to leave the explicit "terminate the alias walk from the callback function" behaviour in the DT-parsing code[1], since there doesn't seem any good reason not to. As Bjorn says, though, it probably is generally useful for the PCI code to have its own knowledge of exactly where DMA can escape the PCI hierarchy - I now wonder if we could actually just do that from the DT/IORT code; if firmware says a particular bridge/etc. has a relationship with an ITS or SMMU, then presumably it's reasonable to infer that DMA can come out of it, thus we could inform the PCI code there and then without it having to quirk things on its own?
> 
> Robin.
> 
> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/13932
> 
>> 
>> Jon.
> 
