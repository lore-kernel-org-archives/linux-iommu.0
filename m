From: "Sironi, Filippo via iommu" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Don't be too aggressive when clearing one
	context entry
Date: Thu, 31 Aug 2017 08:41:25 +0000
Message-ID: <8B5D8830-9DB1-40D9-BB98-C6F277E64F21@amazon.de>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
	<20170830133112.btbsmgbm2clz4767@8bytes.org>
Reply-To: "Sironi, Filippo" <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170830133112.btbsmgbm2clz4767-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <764F48467F75E245B4A727A8C9C48850-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Woodhouse,
	David" <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> On 30. Aug 2017, at 15:31, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> 
> Hi Filippo,
> 
> please change the subject to:
> 
> 	iommu/vt-d: Don't be too aggressive when clearing one context entry
> 
> to follow the convention used in the iommu-tree. Another comment below.

Will do.

> On Mon, Aug 28, 2017 at 04:16:29PM +0200, Filippo Sironi wrote:
>> static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
>> {
>> +	unsigned long flags;
>> +	struct context_entry *context;
>> +	u16 did_old;
>> +
>> 	if (!iommu)
>> 		return;
>> 
>> +	spin_lock_irqsave(&iommu->lock, flags);
>> +	context = iommu_context_addr(iommu, bus, devfn, 0);
>> +	if (!context) {
>> +		spin_unlock_irqrestore(&iommu->lock, flags);
>> +		return;
>> +	}
>> +	did_old = context_domain_id(context);
>> +	spin_unlock_irqrestore(&iommu->lock, flags);
>> 	clear_context_table(iommu, bus, devfn);
> 
> This function is the only caller of clear_context_table(), which does
> similar things (like fetching the context-entry) as you are adding
> above.
> 
> So you can either make clear_context_table() return the old domain-id
> so that you don't need to do it here, or you get rid of the function
> entirely and add the context_clear_entry() and __iommu_flush_cache()
> calls into this code-path.
> 
> Regards,
> 
> 	Joerg

I went for merging domain_context_clear_one() with context_clear_one().

Regards,
Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
