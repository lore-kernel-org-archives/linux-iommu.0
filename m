From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Fri, 14 Sep 2018 15:40:15 +0100
Message-ID: <64e4726e-929f-0e76-6dcc-45a750bde7e9@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
	<aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
	<3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
	<03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191302ECE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191302ECE-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Bie, Tiwei" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar, Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>> This example only needs to modify first-level translation, and works
>> with SMMUv3. The kernel here could be the host, in which case
>> second-level translation is disabled in the SMMU, or it could be the
>> guest, in which case second-level mappings are created by QEMU and
>> first-level translation is managed by assigning PASID tables to the guest.
> 
> the former yes applies to aux domain concept. The latter doesn't -
> you have only one second-level per device. whole PASID table managed
> by guest means you assign the whole device to guest, which is not the
> concept of aux domain here.

Right, in the latter case, the host uses a "normal" domain to assign the
whole PCI function to the guest. But the guest can still use auxiliary
domains like in my example, to sub-assign the PCI function to different
guest userspace applications.

>> So (2) would use iommu_sva_bind_device(), but (1) needs something else.
>> Aren't auxiliary domains suitable for (1)? Why limit auxiliary domain to
>> second-level or nested translation? It seems silly to use a different
>> API for first-level, since the flow in userspace and VFIO is the same as
>> your second-level case as far as MAP_DMA ioctl goes. The difference is
>> that in your case the auxiliary domain supports an additional operation
>> which binds first-level page tables. An auxiliary domain that only
>> supports first-level wouldn't support this operation, but it can still
>> implement iommu_map/unmap/etc.
> 
> Thanks for correcting me on this. You are right that aux domain shouldn't
> impose such limitation on 2nd or nested only. We define aux domain
> as a normal domain (aux takes effect only when attaching to a device),
> thus it should support all capabilities possible on a normal domain.
> 
> btw I'm not sure whether you look at my comment to patch 8/10. I
> explained the rationale why aux domain doesn't interfere with existing
> default domain usage, and in a quick thinking above example might
> not make difference. but need your confirm here. :-)

Yes sorry, I didn't have time to answer, will do it now

Thanks,
Jean
