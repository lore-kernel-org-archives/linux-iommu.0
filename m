From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] iommu: Add event tracing feature to iommu
Date: Fri, 09 Aug 2013 16:41:58 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E61761EFF@sisaex02sj>
References: <1375196229-2784-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org" <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/30/2013 08:57 AM, Shuah Khan wrote:
> Add tracing feature to iommu to report various iommu events. Classes
> iommu_group, iommu_device, iommu_map_unmap, and iommu_amd_event are defined.
>
> iommu_group class events can be enabled to trigger when devices get added
> to and removed from an iommu group. Trace information includes iommu group
> id and device name.
>
> iommu:add_device_to_group
> iommu:remove_device_from_group
>
> iommu_device class events can be enabled to trigger when devices are attached
> to and detached from a domain. Trace information includes device name.
>
> iommu:attach_device_to_domain
> iommu:detach_device_from_domain
>
> iommu_map_unmap class events can be enabled to trigger when iommu map and
> unmap iommu ops. Trace information includes iova, physical address (map event
> only), and size.
>
> iommu:unmap
> iommu:map
>
> iommu_amd_event class can be enabled to trigger when AMD IOMMU driver finds
> events when it polls the IOMMU Event Log. Trace information includes the
> event string derived from the event type in human friendly form, event type,
> id of the domain the device is placed in, device (bus number, slot number,
> and function number), address associated with the event, and flags.
>
> iommu:amd_event
>
> Testing:
> The following is trace is generated when intel-iommu driver adds devices to
> to iommu groups during boot-time during its initialization:
>
>         swapper/0-1     [003] ....     1.854793: add_device_to_group: IOMMU: groupID=0 device=0000:00:00.0
>         swapper/0-1     [003] ....     1.854797: add_device_to_group: IOMMU: groupID=1 device=0000:00:02.0
>
> Added trace calls to iommu_prepare_identity_map() for testing some of the
> conditions that are hard to trigger. Here is the trace from the testing:
>         swapper/0-1     [003] ....     1.854099: amd_event: IOMMU:ILLEGAL_DEV_TABLE_ENTRY 0x01 00:00.0 d=0x0010 a=0x00000000cb800000 f=0x0002
>         swapper/0-1     [003] ....     1.854101: remove_device_from_group: IOMMU: groupID=0 device=0000:00:02.0
>         swapper/0-1     [003] ....     1.854102: attach_device_to_domain: IOMMU: device=0000:00:02.0
>         swapper/0-1     [003] ....     1.854102: detach_device_from_domain: IOMMU: device=0000:00:02.0
>         swapper/0-1     [003] ....     1.854102: map: IOMMU: iova=0x00000000cb800000 paddr=0x00000000cf9fffff size=0x400
>         swapper/0-1     [003] ....     1.854102: unmap: IOMMU: iova=0x00000000cb800000 size=0x400
>

Any comments on this patch? Is this a reasonable approach?

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org | (970) 672-0658
