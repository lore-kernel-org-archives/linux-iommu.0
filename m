From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Fri, 8 Jan 2016 11:15:37 +0800
Message-ID: <CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
	<1451988444-4694-6-git-send-email-vincent.wan@amd.com>
	<20160107120422.GB19149@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160107120422.GB19149-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

2016-01-07 20:04 GMT+08:00 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>:
> On Tue, Jan 05, 2016 at 05:07:23AM -0500, Wan Zongshun wrote:
>> -static inline u16 get_device_id(struct device *dev)
>> +static inline int match_hid_uid(struct device *dev,
>> +                             struct acpihid_map_entry *entry)
>> +{
>> +     const char *hid, *uid;
>> +
>> +     hid = acpi_device_hid(ACPI_COMPANION(dev));
>> +     uid = acpi_device_uid(ACPI_COMPANION(dev));
>> +
>> +     if (!hid || !(*hid))
>> +             return -ENODEV;
>> +
>> +     if (!uid || !(*uid))
>> +             return strcmp(hid, entry->hid);
>> +
>> +     if (!(*entry->uid))
>> +             return strcmp(hid, entry->hid);
>> +
>> +     return -ENODEV;
>> +}
>> +
>> +static inline u16 get_pci_device_id(struct device *dev)
>>  {
>>       struct pci_dev *pdev = to_pci_dev(dev);
>>
>>       return PCI_DEVID(pdev->bus->number, pdev->devfn);
>>  }
>>
>> +static inline int get_acpihid_device_id(struct device *dev,
>> +                                     struct acpihid_map_entry **entry)
>> +{
>> +     struct acpihid_map_entry *p;
>> +
>> +     list_for_each_entry(p, &acpihid_map, list) {
>> +             if (!match_hid_uid(dev, p)) {
>> +                     if (entry)
>> +                             *entry = p;
>> +                     return p->devid;
>> +             }
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static inline u16 get_device_id(struct device *dev)
>> +{
>> +     if (dev_is_pci(dev))
>> +             return get_pci_device_id(dev);
>> +     else
>> +             return get_acpihid_device_id(dev, NULL);
>> +}
>
> This is not robust, get_acpihid_device_id() returns int and can return a
> negative value. This gets lost when converting it to u16 here. So either
> you add error handling for get_acpihid_device_id() in get_device_id() or
> you change get_device_id() to return int too and handle the error at the
> callers of get_device_id().

Joerg,

Please see the following function, since I judge this
'get_acpihid_device_id(dev, NULL) < 0'  in the front of
'get_device_id', so your concern should not exist. I have already
filtered the negative situation in check_device firstly, do you think
it is ok?


static bool check_device(struct device *dev)
{
        u16 devid;
......

        /* No PCI device */
        if (!dev_is_pci(dev) && (get_acpihid_device_id(dev, NULL) < 0))
                return false;

        devid = get_device_id(dev);

.....

        return true;
}


>
>
>         Joerg
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
