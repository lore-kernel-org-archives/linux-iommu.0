From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Thu, 18 Oct 2018 15:04:35 +0800
Message-ID: <0696f645-d2df-23fd-d268-233a748ffff5@linux.intel.com>
References: <CA+icZUXnB2LbB-X_pQeM=OQDEVcWQdUr9TLbG1cXnpwuTe=mNw@mail.gmail.com>
	<95f69db6-becd-adce-5477-264de839bcd8@linux.intel.com>
	<CA+icZUWQL=aMY39k3zUK1KWn0ec-4wsDA8Djmz-7hN9uBJWFcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+icZUWQL=aMY39k3zUK1KWn0ec-4wsDA8Djmz-7hN9uBJWFcQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 10/18/18 2:52 PM, Sedat Dilek wrote:
> On Tue, Oct 16, 2018 at 8:37 AM Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>
>> Hi Sedat,
>>
>> Sorry for late reply.
>>
>> Do you still have this issue with newer rc's (like 4.19-rc8)?
>>
>> I checked the dmesg log you attached there, it seems that the vt-d was
>> not on actually.
>>
> 
> Here my kernel-config and dmesg-logs for Linux v4.19-rc8.

Any issues are you seeing? I didn't see any error in the dmesg dump.

Best regards,
Lu Baolu

> 
> - sed@ -
> 
>>
>> On 9/5/18 8:04 PM, Sedat Dilek wrote:
>>> Hi Joerg,
>>>
>>> "intel_ioomu=on" was working fine here on my ThinkPad T470 with
>>> debian/testing AMD64 with Linux v4.17.y and v4.18.y.
>>>
>>> With testing Linux v4.19-rc1 and v4.19-rc2 my machine is not booting -
>>> black screen.
>>> These kernels are built with LLVM/Clang v7.0.0rc2 (v4.18.y too).
>>>
>>> Furthermore, I switched from GRUB to systemd-boot v239.
>>>
>>> [ /boot/efi/loader/entries/debian.conf ]
>>>
>>> title Debian GNU/Linux buster/sid [ debian kernel ]
>>> linux /vmlinuz-4.17.0-3-amd64
>>> initrd /initrd.img-4.17.0-3-amd64
>>> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro intel_iommu=on
>>>
>>> [ /boot/efi/loader/entries/debian-llvmlinux.conf ]
>>>
>>> title Debian GNU/Linux buster/sid [ llvmlinux kernel (EXPERIMENTAL) ]
>>> linux /vmlinuz-4.19.0-rc2-3-iniza-llvmlinux
>>> initrd /initrd.img-4.19.0-rc2-3-iniza-llvmlinux
>>> options root=UUID=4c2aa544-6e86-44d2-9329-572623867b3d ro
>>>
>>> Any hints or hints to debug this?
>>> Any other kernel boot cheats [1] I can try?
>>>
>>> My kernel-config and dmesg output is attached.
>>>
>>> Thanks in advance.
>>>
>>> Regards,
>>> - Sedat -
>>>
>>>
>>> Documentation/intel_txt.txt
>>> Documentation/admin-guide/kernel-parameters.txt
>>> Documentation/Intel-IOMMU.txt
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n1645
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/Intel-IOMMU.txt
>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/intel_txt.txt
>>>
>>>
>>> _______________________________________________
>>> iommu mailing list
>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
