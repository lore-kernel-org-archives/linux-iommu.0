From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v3 1/2] iommu: Disable preemption around use of
 this_cpu_ptr()
Date: Sun, 26 Jun 2016 12:54:19 +0200
Message-ID: <7b6bfcfc-093a-f90f-94b0-0e89dde8c0e6@leemhuis.info>
References: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
 <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
 <20160615122548.GJ26566@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615122548.GJ26566@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 15.06.2016 14:25, Joerg Roedel wrote:
> On Wed, Jun 01, 2016 at 12:10:08PM +0100, Chris Wilson wrote:
>> Between acquiring the this_cpu_ptr() and using it, ideally we don't =
want
>> to be preempted and work on another CPU's private data. this_cpu_ptr=
()
>> checks whether or not preemption is disable, and get_cpu_ptr() provi=
des
>> a convenient wrapper for operating on the cpu ptr inside a preemptio=
n
>> disabled critical section (which currently is provided by the
>> spinlock). Indeed if we disable preemption around this_cpu_ptr,
>> we do not need the CPU local spinlock - so long as take care that no=
 other
>> CPU is running that code as do perform the cross-CPU cache flushing =
and
>> teardown, but that is a subject for another patch.
> [=E2=80=A6]
>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D96293
> [=E2=80=A6]
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index ba764a0835d3..e23001bfcfee 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -420,8 +420,10 @@ retry:
>> =20
>>  		/* Try replenishing IOVAs by flushing rcache. */
>>  		flushed_rcache =3D true;
>> +		preempt_disable();
>>  		for_each_online_cpu(cpu)
>>  			free_cpu_cached_iovas(cpu, iovad);
>> +		preempt_enable();
>=20
> Why do you need to disable preemption here? The free_cpu_cached_iovas
> function does not need to stay on the same cpu as it iterates over th=
e
> rcaches for all cpus anyway.

Joerg, what's the status here? This made it on my 4.7 regressions
report, as the patches from this thread are supposed to fix a
regression; see
http://thread.gmane.org/gmane.linux.usb.general/143504/focus=3D153154
for details.

Please let me know if if fixes went to mainline already; I did a quick
check and could see any.

Sincerely, your regression tracker for Linux 4.7 (http://bit.ly/28JRmJo=
)
 Thorsten
