From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: fix device remove
Date: Fri, 5 May 2017 16:24:17 -0400
Message-ID: <CAF6AEGvz8ZLue8=P8w4g_SwzaZsuucN1-v4LgJQu8kejKeXagg@mail.gmail.com>
References: <20170505180837.11326-1-robdclark@gmail.com> <20170505182452.GA3575@kroah.com>
 <CAF6AEGsTrOJG2+a=vPc8iLDPOK5rxQujS8wuoCEmBhgT7Zpb9w@mail.gmail.com> <20170505195821.GC7351@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170505195821.GC7351@kroah.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 5, 2017 at 3:58 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, May 05, 2017 at 02:56:00PM -0400, Rob Clark wrote:
>> On Fri, May 5, 2017 at 2:24 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, May 05, 2017 at 02:08:37PM -0400, Rob Clark wrote:
>> >> It looks like it *used* to make sense to free the device.  But now it is
>> >> embedded in 'struct iommu' (which is allocated or embedded in something
>> >> that the device allocated).
>> >>
>> >> Spotted when testing qcom_iommu with CONFIG_DEBUG_TEST_DRIVER_REMOVE.
>> >>
>> >> Fixes: 39ab955 ("iommu: Add sysfs bindings for struct iommu_device")
>> >> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> >> ---
>> >>  drivers/iommu/iommu-sysfs.c | 1 -
>> >>  1 file changed, 1 deletion(-)
>> >>
>> >> diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
>> >> index c58351e..ad19cbb 100644
>> >> --- a/drivers/iommu/iommu-sysfs.c
>> >> +++ b/drivers/iommu/iommu-sysfs.c
>> >> @@ -34,7 +34,6 @@ static const struct attribute_group *iommu_dev_groups[] = {
>> >>
>> >>  static void iommu_release_device(struct device *dev)
>> >>  {
>> >> -     kfree(dev);
>> >>  }
>> >
>> > As per the documentation in the kernel tree, I now get to make fun of
>> > you for doing such a crazh and foolish thing!
>> >
>> > Come on, don't do that, a release function _HAS_ to free the memory
>> > involved.  If not, then it is really broken...
>>
>> There are shenanigans going on.. so release isn't counterpoint to a
>> _probe() which allocates some memory.  See iommu_device_sysfs_add().
>> So I'm not the one you get to make fun of ;-)
>>
>> This the correct thing to do.  Whether the way the extra fake device
>> embedded in something allocated in the iommu driver's probe (and
>> free'd it *it's* _release()) stuff for iommu sysfs stuff works is
>> bonkers or not, I'll let someone else decide..  it was like that when
>> I got here.
>
> If you have multiple reference counts in the same structure, your code
> is wrong.  That is the root issue here that needs to be resolved.  Yes,
> your patch papers over that, but again, it isn't right either.
>

fair enough, I should have been more precise and said that this patch
is "the correct thing to do for how the code works now".. as far as
bigger refactoring, I'll leave that to someone who understands why the
code works the way it currently does.  My patch at least makes things
less wrong.  (But removing an iommu is kind of a crazy thing to do so
it's perhaps a rather theoretical problem.)

BR,
-R
