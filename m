From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 1/2] iommu/arm-smmu-v3: Remove bypass in
	arm_smmu_reset_device
Date: Tue, 24 Apr 2018 19:57:06 +0800
Message-ID: <85c3b7d4-19c0-ea9c-b698-18e199b1da6d@huawei.com>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
	<1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
	<9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9e2f8646-482a-e721-d1b6-e674de48e276-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for your comment!
On 2018/4/24 0:07, Robin Murphy wrote:
> On 23/04/18 12:45, Yisheng Xie wrote:
>> Add a bypass parameter in arm_smmu_device to keep whether smmu device
>> should pypass or not, so parameter bypass in arm_smmu_reset_device can
>> be removed.
> 
> Given that the GBPA configuration implied by the bypass argument here
> is only there to avoid initialising a full stream table when the firmware
> is terminally broken, I wonder if it would make sense to simply skip
> allocating a stream table at all in that case. Then we could just base
> the subsequent SMMUEN/GPBA decision on whether strtab_cfg.strtab is valid or not.
> 
Yes, it may save many memory, and should be care about not access strtab when attach
device or other similar scenario, anyway software can achieve this after move bypass
to struct arm_smmu_device.

Thanks
Yisheng
> Robin.
> 
