From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/8] iommu: Make core iommu-groups code more generic
Date: Thu, 19 Nov 2015 17:06:33 +0800
Message-ID: <1447923993.22313.5.camel@mhfsdcap03>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445464303-18206-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-10-21 at 23:51 +0200, Joerg Roedel wrote:
> Hi,
> 
> this patch-set makes the core code for managing iommu-groups
> more generic by lifting its dependencies on PCI. The core
> function iommu_group_get_for_dev() had a hard dev_is_pci()
> check in it, followed by PCI specific handling.
> 
> This check is removed in favour of the the revived
> device_group() iommu-ops call-back. With this call-back an
> IOMMU driver can define how the devices it manages are
> grouped together. Two functions, one generic and one for PCI
> devices, are provided that can be uses as a device_group()
> call-back or might be used in such a call-back.
> 
> The existing drivers making use of the iommu_group_get_for_dev()
> function are converted to this call-back.
> 
> 	
> 	Joerg
> 
(Resend since some mail servers reject this.)

Hi Joerg,
    Thanks for this patch-set. With this patch-set we can implement our
owner device_group(), then we could achieve all the iommu devices into
the same m4u iommu-group easily.
    
    This patch-set have been merged into v4.4-rc1 where I will get a
WARN while I test iommu_detach_device, below is the warning log:

(151119_13:39:37.472)WARNING:
at /proj/mtk40525/upstreamdev/v4.4/kernel/mediatek/drivers/iommu/iommu.c:1154
(151119_13:39:37.472)Modules linked in:
(151119_13:39:37.472)CPU: 1 PID: 731 Comm: sh Not tainted 4.4.0-rc1+
#37
(151119_13:39:37.472)Hardware name: MediaTek MT8173 evaluation board
(DT)
(151119_13:39:37.472)task: ffffffc076bb4d00 ti: ffffffc076bdc000
task.ti: ffffffc076bdc000
(151119_13:39:37.472)PC is at iommu_detach_device+0x5c/0xb0
(151119_13:39:37.472)LR is at iommu_detach_device+0x30/0xb0
xxx

>From the code, there are 2 places confuse me:
1. It seems that the iommu core has supposed that there is only one
device in each a group. In the iommu_detach_device/iommu_attach_device
there is a checking like this:

        if (iommu_group_device_count(group) != 1) {
                WARN_ON(1);
                goto out_unlock;
        }

   Then for our case(there are many devices in a group), Could we delete
this checking?

2. iommu_detach_device will call __iommu_detach_group in which it will
return directly if group->iommu==group->default_iommu, Unfortunately
both will be the same if we call iommu_group_get_for_dev(). then
iommu_detach_device cann't finish the detach operation.
   And if there are many devices in a group, It seems that we can not
detach whole the group in the iommu_detach_device.
 
/* ============================= */
Below is our add_device() and device_group(), if we call the wrong iommu
interface, please also tell me. Thanks.

static int mtk_iommu_add_device(struct device *dev)
{
        struct iommu_group *group;

        if (!dev->archdata.iommu) /* Not a iommu client device */
                return -ENODEV;

        group = iommu_group_get_for_dev(dev);
        if (IS_ERR(group))
                return PTR_ERR(group);

        iommu_group_put(group);
        return 0;
}

static struct iommu_group *mtk_iommu_device_group(struct device *dev)
{
        struct mtk_iommu_data *data;
        struct mtk_iommu_client_priv *priv;

        priv = dev->archdata.iommu;
        if (!priv)
                return ERR_PTR(-ENODEV);

        /* All the client devices are in the same m4u iommu-group */
        data = dev_get_drvdata(priv->m4udev);
        if (!data->m4ugroup) {
                data->m4ugroup = iommu_group_alloc();
                if (IS_ERR(data->m4ugroup))
                        dev_err(dev, "Failed to allocate M4U IOMMU group
\n");
        }
        return data->m4ugroup;
}
/* ============================= */
