From: Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Fri, 5 May 2017 14:05:08 +0200
Message-ID: <0402e0cb-a945-a9a2-7157-fd5989b6924a@markju.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
	<CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I recognized (with npt disabled) the VM is getting slower over time, 
like in Windows the system process is taking more and more CPU usage. A 
soft restart does help makeing it "usable" again. Also wondering if this 
is an hardware related issue in Ryzen, so the upcoming Naples does have 
it too? This would be a nogo for the server platform and, in my eyes, 
the death even pre-released.

Regards


Am 03.05.2017 um 18:28 schrieb Nick Sarnie:
> On Wed, May 3, 2017 at 10:37 AM, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi,
>>
>> There are a lot of messages/threads out there about bad performance while
>> using AMDs Ryzen with KVM GPU passthrough. It revolves all on
>> enabling/disabling npt, while enabled overall VM performance is nice but the
>> GPU performance gives me about 20% (and a lot of drops to zero GPU usage,
>> while CPU/Disk/Ram also doing nothing) compared to npt disabled. But while
>> npt is disabled overall VM performance is like beeing on 4x86 with floppy
>> disk as only storage. (Ex. it takes 2 seconds just to open startmenu while
>> host and vm are in idle, and neither CPU pinning, changing CPU model,
>> changing storage device nor using hugepages changed anything).
>>
>> So everything I read pointed to a bug in the npt implementation? Anything I
>> could do to get closer to the "thing" issuing this?
>>
>> Best Regards
>>
>> efeu
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> I heard from Joerg that it might be related to a lower intercept rate
> being used when NPT is enabled, but we haven't been able to find a way
> to trace that to confirm.
