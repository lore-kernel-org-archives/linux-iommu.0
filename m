From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 16/40] arm64: mm: Pin down ASIDs for sharing mm with
	devices
Date: Thu, 17 May 2018 11:01:55 +0100
Message-ID: <81662b4f-2210-665f-21cf-7679bfa9f97a@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-17-jean-philippe.brucker@arm.com>
	<20180515141658.vivrgcyww2pxumye@armageddon.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180515141658.vivrgcyww2pxumye-+1aNUgJU5qkijLcmloz0ER/iLCjYCKR+VpNB7YpNyf8@public.gmane.org>
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
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/05/18 15:16, Catalin Marinas wrote:
> Hi Jean-Philippe,
> 
> On Fri, May 11, 2018 at 08:06:17PM +0100, Jean-Philippe Brucker wrote:
>> +unsigned long mm_context_get(struct mm_struct *mm)
>> +{
>> +	unsigned long flags;
>> +	u64 asid;
>> +
>> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
>> +
>> +	asid = atomic64_read(&mm->context.id);
>> +
>> +	if (mm->context.pinned) {
>> +		mm->context.pinned++;
>> +		asid &= ~ASID_MASK;
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (nr_pinned_asids >= max_pinned_asids) {
>> +		asid = 0;
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (!asid_gen_match(asid)) {
>> +		/*
>> +		 * We went through one or more rollover since that ASID was
>> +		 * used. Ensure that it is still valid, or generate a new one.
>> +		 * The cpu argument isn't used by new_context.
>> +		 */
>> +		asid = new_context(mm, 0);
>> +		atomic64_set(&mm->context.id, asid);
>> +	}
>> +
>> +	asid &= ~ASID_MASK;
>> +
>> +	nr_pinned_asids++;
>> +	__set_bit(asid2idx(asid), pinned_asid_map);
>> +	mm->context.pinned++;
>> +
>> +out_unlock:
>> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
>> +
>> +	return asid;
>> +}
> 
> With CONFIG_UNMAP_KERNEL_AT_EL0 (a.k.a. KPTI), the hardware ASID has bit
> 0 set automatically when entering user space (and cleared when getting
> back to the kernel). If the returned asid value here is going to be used
> as is in the calling code, you should probably set bit 0 when KPTI is
> enabled.
> 

Oh right, I'll change this

Thanks,
Jean
