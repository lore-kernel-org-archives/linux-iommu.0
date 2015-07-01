From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Wed, 1 Jul 2015 08:44:59 +0200
Message-ID: <20150701064459.GP18569@8bytes.org>
References: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
	<20150629193402.GM18569@8bytes.org>
	<CAPBX1xLA_GDeoi9wq-9A7njwzL3NBqJYYT_PqhwEzBAg=9=8kA@mail.gmail.com>
	<20150630074454.GO18569@8bytes.org>
	<CAPBX1x+OK8EMwDsripY71jF44d73Qv0jBxyM+jJgPMzNVPTyaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPBX1x+OK8EMwDsripY71jF44d73Qv0jBxyM+jJgPMzNVPTyaw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi George,

On Wed, Jul 01, 2015 at 01:20:59PM +0800, George Wang wrote:
> [root@hp-dl385pg8-09 linux-next]# dmidecode|grep -A16 "System Information"
> System Information
>     Manufacturer: HP
>     Product Name: ProLiant DL385p Gen8
>     Version: Not Specified
>     Serial Number: 6CU428FNLL
>     UUID: 32333536-3330-4336-5534-3238464E4C4C
>     Wake-up Type: Power Switch
>     SKU Number: 653203-B21
>     Family: ProLiant

Thanks for that info, so its HP hardware which has it.

> Thanks for you work. Apply this patch, and it works good for me.

Thanks for testing, I send the fix upstream asap.


	Joerg
