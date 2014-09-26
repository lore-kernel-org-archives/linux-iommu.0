From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCHv7 07/26] driver core: amba: add device binding path
	'driver_override'
Date: Fri, 26 Sep 2014 17:10:52 +0200
Message-ID: <CAG8rG2zbiwhN3VPw4vgeVEU6EOxDVuHmT7e2bUjfmNUkFPxV6Q@mail.gmail.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
	<1411483586-29304-8-git-send-email-a.motakis@virtualopensystems.com>
	<1411512325.24563.59.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411512325.24563.59.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Ok, they will be posted separately.

Thanks

On Wed, Sep 24, 2014 at 12:45 AM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 2014-09-23 at 16:46 +0200, Antonios Motakis wrote:
>> As already demonstrated with PCI [1] and the platform bus [2], a
>> driver_override property in sysfs can be used to bypass the id matching
>> of a device to a AMBA driver. This can be used by VFIO to bind to any AMBA
>> device requested by the user.
>>
>> [1] http://lists-archives.com/linux-kernel/28030441-pci-introduce-new-device-binding-path-using-pci_dev-driver_override.html
>> [2] https://www.redhat.com/archives/libvir-list/2014-April/msg00382.html
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/amba/bus.c       | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/amba/bus.h |  1 +
>>  2 files changed, 45 insertions(+)
>
> Why are 7 & 8 being dragged into this series?  Combine them into a
> single patch and post it separately.
>
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 3cf61a1..473177c 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/amba/bus.h>
>>  #include <linux/sizes.h>
>> +#include <linux/limits.h>
>>
>>  #include <asm/irq.h>
>>
>> @@ -42,6 +43,10 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>>       struct amba_device *pcdev = to_amba_device(dev);
>>       struct amba_driver *pcdrv = to_amba_driver(drv);
>>
>> +     /* When driver_override is set, only bind to the matching driver */
>> +     if (pcdev->driver_override)
>> +             return !strcmp(pcdev->driver_override, drv->name);
>> +
>>       return amba_lookup(pcdrv->id_table, pcdev) != NULL;
>>  }
>>
>> @@ -58,6 +63,44 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
>>       return retval;
>>  }
>>
>> +static ssize_t driver_override_show(struct device *_dev,
>> +                                 struct device_attribute *attr, char *buf)
>> +{
>> +     struct amba_device *dev = to_amba_device(_dev);
>> +
>> +     return sprintf(buf, "%s\n", dev->driver_override);
>> +}
>> +
>> +static ssize_t driver_override_store(struct device *_dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +     struct amba_device *dev = to_amba_device(_dev);
>> +     char *driver_override, *old = dev->driver_override, *cp;
>> +
>> +     if (count > PATH_MAX)
>> +             return -EINVAL;
>> +
>> +     driver_override = kstrndup(buf, count, GFP_KERNEL);
>> +     if (!driver_override)
>> +             return -ENOMEM;
>> +
>> +     cp = strchr(driver_override, '\n');
>> +     if (cp)
>> +             *cp = '\0';
>> +
>> +     if (strlen(driver_override)) {
>> +             dev->driver_override = driver_override;
>> +     } else {
>> +            kfree(driver_override);
>> +            dev->driver_override = NULL;
>> +     }
>> +
>> +     kfree(old);
>> +
>> +     return count;
>> +}
>> +
>>  #define amba_attr_func(name,fmt,arg...)                                      \
>>  static ssize_t name##_show(struct device *_dev,                              \
>>                          struct device_attribute *attr, char *buf)    \
>> @@ -80,6 +123,7 @@ amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
>>  static struct device_attribute amba_dev_attrs[] = {
>>       __ATTR_RO(id),
>>       __ATTR_RO(resource),
>> +     __ATTR_RW(driver_override),
>>       __ATTR_NULL,
>>  };
>>
>> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
>> index fdd7e1b..7c011e7 100644
>> --- a/include/linux/amba/bus.h
>> +++ b/include/linux/amba/bus.h
>> @@ -32,6 +32,7 @@ struct amba_device {
>>       struct clk              *pclk;
>>       unsigned int            periphid;
>>       unsigned int            irq[AMBA_NR_IRQS];
>> +     char                    *driver_override;
>>  };
>>
>>  struct amba_driver {
>
>
>



-- 
Antonios Motakis
Virtual Open Systems
